# Rusty Template

Rusty Template is the smallest complete downstream Product Model. It is a
working product shape, not a framework or a web application: Rust owns the
admitted composition, live Product Kernel state, schedule/timeline results,
content closure, and retained projection. TypeScript is limited to the
build-time Runtime Composition authoring lane and the bounded DOM UI.

## Adjacent Engine checkout

Place the Engine and product checkouts beside one another:

~~~text
rusty-workspace/
  rusty-engine/
  rusty-template/
~~~

The template consumes the public rusty CLI from the adjacent Engine checkout
and the Engine-owned application-host artifact. It never clones, fetches,
builds, pins, or mutates that checkout. Build the Engine's isolated Rules and
Render artifacts there when they are missing, then run:

~~~bash
./scripts/verify.sh
~~~

When this repository is being exercised from a separate worktree, set
RUSTY_ENGINE_ROOT to the stable Engine checkout and RUSTY_CLI to its public
rusty executable.

The verification script uses a disposable copy of this product. It admits and
inspects the exact composition, builds and regenerates the Product Assembly
byte-for-byte, checks package closure, and runs the public browser proof through
one Engine canvas plus the bounded Product UI. The optional installed Tauri
WebDriver proof is intentionally separate and is not implied by Chromium
success.

## Layout

~~~text
rusty.toml                 product identity and host policy
rules/main.ts              pure Runtime Composition authoring
kernel/entry.rs            Product Kernel authority and transaction
ui/main.ts                 bounded observational DOM UI
content/                   declared product-owned runtime resources
generated/.keep            ignored CLI receipts and generated closure
scripts/verify.sh          disposable public-CLI acceptance gate
docs/architecture.md       ownership and workflow notes
~~~

The sample counter is deliberately small but complete: physical W and the
DOM button claim one typed increment intent, Engine runs the standard
observe-pairs capability and recurring schedule, the Product Kernel queues
mutation operations, and a finite timeline contributes its own result. UI
projection remains observational.

For the provider contract, read the [downstream repository bootstrap](https://github.com/FuzzySlipper/rusty-engine/blob/main/docs/topics/development/downstream-repository-bootstrap.md), [greenfield product path](https://github.com/FuzzySlipper/rusty-engine/blob/main/docs/topics/development/greenfield-downstream-product.md), [renderer and Studio boundary](https://github.com/FuzzySlipper/rusty-engine/blob/main/docs/topics/development/downstream-renderer-and-studio.md), and [Rusty Engine design](https://github.com/FuzzySlipper/rusty-engine/blob/main/docs/design.md).
