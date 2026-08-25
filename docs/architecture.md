# Product Layout

This template is a complete vertical through the public Engine Product Model:

~~~text
rules/main.ts
  -> Rusty CLI admission and canonical composition
  -> kernel/entry.rs Product Kernel
  -> Engine schedule, standard capability, input, lifecycle, and timeline lanes
  -> Product Assembly and declared content closure
  -> Product Browser Host
  -> one Engine canvas plus bounded ui/main.ts DOM projection
~~~

The Rust Product Kernel is the only owner of the counter's live facts and
mutation transaction. It gathers source-linked entity facts for the standard
runtime.observe-pairs capability, queues typed operation receipts, and
projects counter.v1. Engine owns the structural lifecycle, input admission,
schedule ordering, timeline release, and host transport; the product owns
meaning and mutation planning.

rules/main.ts is pure build-time authoring. It lowers to the Rust-owned
Runtime Composition contract and cannot evaluate, schedule, persist, or mutate
anything in play. ui/main.ts claims the same typed increment intent as the
physical W mapping and observes the Rust projection; it does not own a second
canvas, renderer, state store, or browser authority.

generated/ is an ignored receipt lane. A clean product source contains only
the manifest, authoring, kernel, UI, and declared content. scripts/verify.sh
uses the public adjacent Engine CLI against a disposable copy so source
validation, deterministic Assembly regeneration, package closure, and browser
evidence remain separate from product source.
