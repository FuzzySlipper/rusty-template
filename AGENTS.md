# Rusty Template agent guidance

## Purpose

This repository is a small, runnable downstream Product Model reference. It
is not an Engine implementation, generic game framework, or web application.
The adjacent Rusty Engine checkout is the provider and is consumed through its
public CLI and published application-host artifacts.

Read the Engine's portable downstream guidance when available:

- downstream repository bootstrap
- greenfield downstream product path
- downstream renderer and Studio boundary

## Authority

- Rust Product Kernel code in kernel/entry.rs owns live product facts, meaning,
  mutation planning, transaction publication, and retained UI projection.
- Engine owns structural composition admission, input/lifecycle/schedule/timeline
  mechanisms, standard capability execution, and host transport.
- rules/main.ts is pure build-time authoring for the Rust-owned Runtime
  Composition wire contract. It is not an evaluator, scheduler, save model, or
  live state store.
- ui/main.ts is bounded DOM presentation and typed intent adaptation. It
  observes the Product Kernel projection and never mutates product state,
  creates a second canvas, or imports renderer internals.
- content/ contains declared product-owned resources. generated/ contains
  ignored Engine receipts and generated closure only.

Do not add a browser storage authority, generic command bus, TypeScript runtime
evaluator, private Engine import, second renderer/canvas, or product scheduler.

## Engine boundary

The sibling Engine checkout must remain adjacent at ../rusty-engine for local
verification. This repository must not clone, fetch, pin, build, reset, or
otherwise mutate it. Use the public rusty CLI from that checkout and the
published application-host/product-browser-host artifacts.
For a separate task worktree, RUSTY_ENGINE_ROOT and RUSTY_CLI may point at the
stable Engine checkout and its public CLI without changing product source.

## Layout

~~~text
rusty.toml       product identity, lifecycle, UI projection, content, wrappers
rules/main.ts    pure Runtime Composition authoring
kernel/entry.rs  concrete Product Kernel and mutation planner
ui/main.ts       bounded DOM UI and typed intent claim
content/         declared runtime resources and manifest
generated/       ignored CLI receipts (only .keep is source)
scripts/         disposable public-CLI verification
docs/            compact architecture notes
~~~

Product identity, application ID, title, and storage namespace are deliberately
template-specific. A product created from this repository must rename them
before publishing.

## Verification

From the repository root, run:

~~~bash
./scripts/verify.sh
~~~

The gate uses a disposable product copy and the adjacent stable Engine CLI. It
checks admission, inspection, Product Assembly generation, byte-identical
delete/regenerate behavior, package closure, and Chromium browser evidence.
The browser proof is not packaged Tauri/WebDriver proof; select that separately
only in an environment with the native prerequisites.

Keep generated outputs untracked. Do not add Cargo, Vite, npm, or Engine host
machinery to this repository merely to make the sample convenient.
