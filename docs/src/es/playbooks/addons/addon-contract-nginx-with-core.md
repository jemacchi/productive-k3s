<!-- generated: playbooks-export-mkdocs -->
# Addon Contract Nginx With Core

Cross-check the `nginx` add-on source package against the current `productive-k3s-core` source validation contract.

## Comando directo del repositorio

```bash
cd productive-k3s-addons
ADDON=nginx PRODUCTIVE_K3S_CORE_REPO_DIR=../productive-k3s-core make -C ./tests test-contract
```

## Vista del cast

<div class="pk3s-playbook-cast-empty">
  <p>Todavía no hay un cast canónico publicado para este playbook.</p>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-addons)

## Detalle del escenario

## Goal

Cross-check the `nginx` add-on source package against the current `productive-k3s-core` source validation contract.

## When to use it

- when `core` changed its add-on contract
- before releasing a new `nginx` source package revision
- when validating `addons` and `core` together on `development`

## Prerequisites

- local checkout at `productive-k3s-addons`
- local checkout at `productive-k3s-core`

## Expected result

- `core` accepts the `nginx` source package as valid input for its development-side source validator
- no live cluster installation
