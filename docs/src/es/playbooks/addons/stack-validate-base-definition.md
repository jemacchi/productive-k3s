<!-- generated: playbooks-export-mkdocs -->
# Stack Validate Base Definition

Validate the `base` stack definition and inspect its declared add-on composition.

## Comando directo del repositorio

```bash
bash ./scripts/validate-addon-package.sh . --kind stack --name base
awk /\^metadata:/\{in_meta=1\;next\}\ in_meta\ \&\&\ /\^\ \ name:/\{print\ \"stack=\"\ \$2\}\ /\^spec:/\{in_spec=1\;next\}\ in_spec\ \&\&\ /\^\ \ addons:/\{in_addons=1\;next\}\ in_addons\ \&\&\ /\^\ \ \ \ -\ /\{sub\(/\^\ \ \ \ -\ /\,\"\"\,\$0\)\;\ print\ \"addon=\"\ \$0\;\ next\}\ in_addons\ \&\&\ \!/\^\ \ \ \ -\ /\{exit\} ./stacks/base/stack.yaml
```

## Vista del cast

<div class="pk3s-playbook-cast-empty">
  <p>Todavía no hay un cast canónico publicado para este playbook.</p>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-addons)

## Detalle del escenario

## Goal

Validate the `base` stack definition and inspect its declared add-on composition.

## When to use it

- when reviewing the public stack contract
- after changing `stacks/base/stack.yaml`
- before validating the same stack against `core`

## Prerequisites

- local checkout at `productive-k3s-addons`

## Expected result

- validation of `base` as a source stack
- visible list of referenced public add-ons
- no cluster mutation
