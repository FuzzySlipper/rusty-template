# Rusty Template

Rusty Template is a deliberately small downstream NativeAOT C# product. Its
counter state and application behavior live in safe C#; Rusty Engine supplies
the lifecycle, update loop, typed input, UI projection transport, and host.

> The product decides. The Engine guarantees.

The former Rust Product Model, TypeScript runtime-composition, and public
`rusty` CLI lanes have been retired. They remain available in Git history as
examples of an earlier architecture, not as supported source to extend.

## Repository shape

```text
src/
  RustyTemplate.Game/          safe C# counter/product logic
  RustyTemplate.NativeProduct/ thin NativeAOT composition project
  ui/                          DOM-only companion and browser bundle script
content/                       empty product content root for the Engine host
scripts/
  build-csharp.sh              focused managed build and NativeAOT publish
  generate-browser-bundle.mjs Engine host plus DOM UI bundle helper
  run-csharp.sh                direct Engine-hosted product runner
docs/architecture.md           current ownership and lifecycle notes
```

Keep this repository beside the Engine checkout:

```text
dev/
  rusty-engine/
  rusty-template/
```

The product project resolves the Engine through `EngineRoot`, which may be
overridden for a deliberate checkout. It does not clone, fetch, pin, or
mutate that checkout.

## Build and run

Run the focused checks from the repository root:

```bash
./scripts/build-csharp.sh
```

To start the Engine's standard browser host after publishing:

```bash
./scripts/run-csharp.sh --port 8787
```

The runner generates an ignored browser bundle, publishes the NativeAOT
library, and starts `csharp-product-runtime` with one direct typed `increment`
intent. The DOM button claims that intent and observes the product's typed
counter projection. The browser host and any canvas remain Engine-owned.

## Working on the product

Read [`AGENTS.md`](AGENTS.md), the adjacent Engine's C# SDK guidance, and
[`docs/architecture.md`](docs/architecture.md). Keep product logic in
`RustyTemplate.Game`, keep `NativeProduct` thin, and use named generated
Engine services. If an Engine capability is missing, record the upstream need
and stop instead of adding Rust, browser logic, a JSON bridge, or handwritten
interop downstream.
