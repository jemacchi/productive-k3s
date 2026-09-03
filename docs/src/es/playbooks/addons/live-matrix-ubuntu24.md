<!-- generated: playbooks-export-mkdocs -->
# Live Matrix Ubuntu24

Run the full live matrix of public add-ons and stacks inside a fresh Ubuntu 24 VM through the repository's existing harness.

## Comando directo del repositorio

```bash
cd productive-k3s-addons
PRODUCTIVE_K3S_CORE_REPO_DIR=../productive-k3s-core make -C ./tests test-live-matrix-ubuntu24
```

## Vista del cast

<div class="pk3s-playbook-cast-empty">
  <p>Todavía no hay un cast canónico publicado para este playbook.</p>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-addons)

## Detalle del escenario

## Goal

Run the full live matrix of public add-ons and stacks inside a fresh Ubuntu 24 VM through the repository's existing harness.

## When to use it

- when you need the highest-confidence live validation path for `addons`
- when the local host already has too much state and would hide meaningful logs
- before recording realistic casts for add-on lifecycle demos

## Prerequisites

- local checkout at `productive-k3s-addons`
- local checkout at `productive-k3s-core`
- `multipass`
- enough disk and network bandwidth to bootstrap a fresh VM and pull images

## Expected result

- a clean Ubuntu 24 VM is bootstrapped through the existing `core` test harness
- the public add-on and stack live matrix runs inside that VM
- test artifacts are copied back under `productive-k3s-addons/test-artifacts/`
