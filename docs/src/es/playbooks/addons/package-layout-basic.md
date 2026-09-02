<!-- generated: playbooks-export-mkdocs -->
# Package Layout Basic

Validate the full `productive-k3s-addons` source-tree contract before discussing individual add-ons or stacks.

## Comando directo del repositorio

```bash
cd productive-k3s-addons
bash ./scripts/validate-addon-package.sh .
```

## Vista del cast

<div class="pk3s-playbook-cast-empty">
  <p>Todavía no hay un cast canónico publicado para este playbook.</p>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-addons)

## Detalle del escenario

## Goal

Validate the full `productive-k3s-addons` source-tree contract before discussing individual add-ons or stacks.

## When to use it

- after structural edits under `addons/` or `stacks/`
- when you want a quick sanity check from a clean checkout
- before running matrix or live validation

## Prerequisites

- local checkout at `productive-k3s-addons`

## Expected result

- validation of required `addon.yaml` and `stack.yaml` structure
- confirmation that required hook scripts and impact metadata are present
- no cluster or host mutations
