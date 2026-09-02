<!-- generated: playbooks-export-mkdocs -->
# Unsupported Command Contract

Show the readable failure contract for an unsupported top-level `pk3s` command.

## Comando directo del repositorio

```bash
cd productive-k3s-cli
bash -lc 'set +e; ./pk3s unsupported-command; code=$?; printf "\n[expected-exit] %s\n" "${code}"; test "${code}" -ne 0'
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/unsupported-command-contract.cast" data-cast-title="Unsupported Command Contract">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/unsupported-command-contract.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-cli)
- [Abrir cast crudo](../../../assets/playbooks/casts/cli/unsupported-command-contract.cast)

## Detalle del escenario

Show the readable failure contract for an unsupported top-level `pk3s` command.

Use this when you want to confirm that:

- unsupported commands fail with a non-zero exit status
- the CLI still prints a readable top-level usage summary
- the negative path is explicit and operator-friendly
