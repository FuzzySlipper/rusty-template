# Rusty Template C# downstream guidance

## Direction and ownership

Rusty Template is a small, ordinary NativeAOT C# product hosted by the
adjacent `/home/dev/rusty-engine` checkout. The C# product is the only local
game/runtime lane. The old Rust Product Model kernel, TypeScript composition
authoring, and `rusty` CLI workflow are retired; Git history is donor material
only.

> The product decides. The Engine guarantees.

- C# owns the counter's application logic, state, meaning, and product UI
  facts.
- Rusty Engine owns lifecycle and update admission, input delivery, UI
  projection transport, renderer/host integration, and other named Engine
  mechanisms.
- TypeScript is limited to the DOM companion. It must not render game
  elements, retain gameplay state, or create a second loop or transport.
- Do not add downstream Rust, Product Model, runtime composition authoring,
  JSON invocation, handwritten ABI/P/Invoke, or a private scheduler.

Read the adjacent Engine's `AGENTS.md`, `docs/architecture.md`, and
`docs/csharp-sdk.md` before changing the product/Engine boundary.

## Source lanes

- `src/RustyTemplate.Game/` is ordinary safe C# product code. It references
  the generated safe `Rusty.Engine` SDK and owns the counter domain.
- `src/RustyTemplate.NativeProduct/` is the thin NativeAOT composition project.
  Its assembly attribute selects the product; the Engine source generator
  owns exports and ABI plumbing. Do not add gameplay or handwritten interop
  there.
- `src/ui/` contains only static/DOM UI. The Engine browser host owns the
  canvas, renderer, and host input delivery.

Generated and intermediate output belongs under ignored build directories.
The generated C# inputs are never edited or committed.

## Missing capabilities and evidence

If the safe generated Engine API cannot express a needed mechanism, name the
exact upstream capability, file or link its Engine task when authorized, and
stop. Do not invent a downstream substitute merely to complete the task.

Use only focused evidence for the active change: a managed product build and
NativeAOT publish are sufficient for this template. Do not revive the removed
Product Model/browser verification gate or add broad tests and proof ceremony.
Preserve unrelated work and never mutate the adjacent Engine checkout.
