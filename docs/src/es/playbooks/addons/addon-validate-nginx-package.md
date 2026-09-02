<!-- generated: playbooks-export-mkdocs -->
# Addon Validate Nginx Package

Validate the public `nginx` add-on source package as the simplest representative add-on in the catalog.

## Comando directo del repositorio

```bash
cd productive-k3s-addons
bash ./scripts/validate-addon-package.sh . --kind addon --name nginx
```

## Vista del cast

<div class="pk3s-playbook-cast-empty">
  <p>Todavía no hay un cast canónico publicado para este playbook.</p>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-addons)

## Detalle del escenario

## Goal

Validate the public `nginx` add-on source package as the simplest representative add-on in the catalog.

## When to use it

- when reviewing add-on packaging conventions
- when you want a short first example before stack-oriented cases
- before demoing the public host contract

## Prerequisites

- local checkout at `productive-k3s-addons`

## Expected result

- `nginx` passes source package validation
- no dependency on a live cluster
- no writes outside temporary shell state
