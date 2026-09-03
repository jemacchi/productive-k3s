<!-- generated: playbooks-export-mkdocs -->
# Stack Contract Base With Core

Validate the `base` stack source against the current `productive-k3s-core` stack contract.

## Comando directo del repositorio

```bash
cd productive-k3s-addons
STACK=base PRODUCTIVE_K3S_CORE_REPO_DIR=../productive-k3s-core make -C ./tests test-contract
```

## Vista del cast

<div class="pk3s-playbook-cast-empty">
  <p>Todavía no hay un cast canónico publicado para este playbook.</p>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-addons)

## Detalle del escenario

## Goal

Validate the `base` stack source against the current `productive-k3s-core` stack contract.

## When to use it

- when `core` changes stack validation rules
- when `base` stack content changes
- before live matrix runs that depend on the same stack members

## Prerequisites

- local checkout at `productive-k3s-addons`
- local checkout at `productive-k3s-core`

## Expected result

- `core` accepts the `base` stack source definition
- no live cluster work is required
