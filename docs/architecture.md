# Current product architecture

Rusty Template is an ordinary managed C# product loaded by Rusty Engine's
NativeAOT product runtime:

```text
C# counter state and product lifecycle
  -> Rusty.Engine safe service surface
  -> generated NativeProduct bootstrap and ABI
  -> Rust Engine lifecycle, input, UI transport, and host
  -> Engine browser host plus DOM-only product UI
```

The arrows describe cooperation, not a second product authority. C# decides
what an increment means and owns the counter value. Engine admits update facts
and typed direct input, and transports the product's UI projection to the
browser. The product never owns a renderer, canvas, browser state store, or
clock.

## Source owners

| Path | Owner | Role |
| --- | --- | --- |
| `src/RustyTemplate.Game/` | C# product | Counter state, input interpretation, and projection facts. |
| `src/RustyTemplate.NativeProduct/` | Engine generator integration | One assembly selection attribute and project references only. |
| `src/ui/main.js` | C# product UI lane | DOM button and counter label; no game state or rendering. |
| `scripts/generate-browser-bundle.mjs` | Product tooling | Combines the Engine browser host with the static UI module. |
| `content/` | Product/host | Currently empty; retained as the explicit host content root. |

The generated C# contracts, raw bindings, native bootstrap, and browser host
artifacts are Engine-owned outputs. They are ignored or consumed from the
adjacent Engine checkout and are not manually edited here.

## Lifecycle and data flow

1. The Engine runtime loads the published NativeAOT library and invokes its
   generated product bind/create path.
2. The product constructor receives `ProductCreateContext` and opens one typed
   UI stream through `IEngineContext.Ui`.
3. Engine calls `Start`, then sends admitted `ProductUpdate` values. A DOM
   button claims the configured `increment` direct intent; C# interprets each
   active direct-digital event and updates its own counter.
4. C# publishes a small typed `UiValue` object through the Engine UI service.
   The DOM module observes the projection and updates its local label.
5. Engine owns pause/resume/restart/shutdown admission, the browser host, and
   any canvas or renderer resources. Product `Dispose` releases its UI stream.

There is no runtime composition file, Product Model kernel, downstream Rust
crate, TypeScript gameplay evaluator, JSON invocation protocol, second loop,
or handwritten ABI in the current path.

## Evidence boundary

The useful proof for this repository is that the managed product compiles and
the NativeAOT composition publishes for `linux-x64`. Browser or interactive
parity testing is deliberately outside this small migration task; the runner
exists for local exploration after those focused checks pass.
