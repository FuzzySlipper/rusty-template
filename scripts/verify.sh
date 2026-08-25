#!/usr/bin/env bash
set -euo pipefail

template_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
engine_root="${RUSTY_ENGINE_ROOT:-$template_root/../rusty-engine}"
rusty_bin="${RUSTY_CLI:-rusty}"

if ! command -v "$rusty_bin" >/dev/null 2>&1; then
  printf '%s\n' "Missing the public Rusty CLI: $rusty_bin" >&2
  printf '%s\n' "Build or install the CLI from the adjacent rusty-engine checkout, then retry." >&2
  exit 1
fi

for required in \
  "$engine_root/rules/packages/runtime-composition-authoring/dist" \
  "$engine_root/render/artifacts/application-host/index.js" \
  "$engine_root/render/artifacts/product-browser-host/product-browser-host.js"; do
  if [[ ! -e "$required" ]]; then
    printf '%s\n' "Missing prepared Engine artifact: $required" >&2
    printf '%s\n' "Prepare the isolated Rules and Render owners in the adjacent Engine checkout, then retry." >&2
    exit 1
  fi
done

scratch_root="$(mktemp -d "${TMPDIR:-/tmp}/rusty-template-product.XXXXXX")"
product_root="$scratch_root/product"
cleanup() {
  rm -rf "$scratch_root"
}
trap cleanup EXIT

mkdir "$product_root"
# Copy the source tree as a product, explicitly excluding either a normal
# checkout's .git directory or a linked-worktree .git file. The disposable
# root must be a product root, never a nested Git checkout.
tar --exclude='./.git' -cf - -C "$template_root" . | tar -xf - -C "$product_root"
rm -rf "$product_root/generated"
mkdir "$product_root/generated"

rusty() {
  "$rusty_bin" "$@"
}

echo "[check] admit Runtime Composition, Product Kernel, UI, and content closure"
rusty check --path "$product_root"

echo "[build] generate and inspect the closed Product Assembly"
rusty build --path "$product_root"
rusty inspect all --path "$product_root"
assembly="$product_root/generated/product-assembly/assembly.json"
cp "$assembly" "$scratch_root/assembly.first.json"

echo "[build] delete and regenerate byte-identical Assembly"
rm -rf "$product_root/generated"
mkdir "$product_root/generated"
rusty build --path "$product_root"
cmp "$scratch_root/assembly.first.json" "$product_root/generated/product-assembly/assembly.json"

echo "[package] verify package closure without installed desktop proof"
rusty package --path "$product_root" --wrapper desktop

echo "[browser] run the public one-canvas Product Browser Host proof"
# The stable Engine browser harness owns the optional installed-host branch.
# Remove the wrapper declaration so this invocation remains Chromium-only.
sed -i '/^\[\[wrappers\]\]/,$d' "$product_root/rusty.toml"
rusty test --path "$product_root"

echo "[ok] Rusty Template Product Model verification passed"
