<!-- generated: playbooks-export-mkdocs -->
# Stack Validate Base Definition

Validate the `base` stack definition and inspect its declared add-on composition.

## Repository-local command

```bash
bash ./scripts/validate-addon-package.sh . --kind stack --name base
awk /\^metadata:/\{in_meta=1\;next\}\ in_meta\ \&\&\ /\^\ \ name:/\{print\ \"stack=\"\ \$2\}\ /\^spec:/\{in_spec=1\;next\}\ in_spec\ \&\&\ /\^\ \ addons:/\{in_addons=1\;next\}\ in_addons\ \&\&\ /\^\ \ \ \ -\ /\{sub\(/\^\ \ \ \ -\ /\,\"\"\,\$0\)\;\ print\ \"addon=\"\ \$0\;\ next\}\ in_addons\ \&\&\ \!/\^\ \ \ \ -\ /\{exit\} ./stacks/base/stack.yaml
```

## Cast preview

<div class="pk3s-playbook-cast-empty">
  <p>No canonical cast is published for this playbook yet.</p>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-addons)

## Scenario details

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
