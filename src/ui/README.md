# Template UI lane

`main.js` is the product's small DOM-only companion. It claims the typed
`increment` intent and observes the Engine-admitted `rusty.template.counter`
projection. It does not own counter state, input delivery, a canvas, a
renderer, or a game loop.

The adjacent Engine browser-host artifact and this module are combined by
`scripts/generate-browser-bundle.mjs` into ignored `generated/` output.
