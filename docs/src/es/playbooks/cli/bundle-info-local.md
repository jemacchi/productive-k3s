<!-- generated: playbooks-export-mkdocs -->
# Bundle Info Local

Inspect local sibling bundle resolution for both `core` and `infra` through `pk3s`.

## Comando directo del repositorio

```bash
cd productive-k3s-cli
bash -lc 'PRODUCTIVE_K3S_SOURCE=local ./pk3s bundle core info --json && printf "\n" && PRODUCTIVE_K3S_SOURCE=local ./pk3s bundle infra info --json'
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/bundle-info-local.cast" data-cast-title="Bundle Info Local">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/bundle-info-local.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-cli)
- [Abrir cast crudo](../../../assets/playbooks/casts/cli/bundle-info-local.cast)

## Detalle del escenario

Inspect local sibling bundle resolution for both `core` and `infra` through `pk3s`.

Use this when you want a short proof that:

- `pk3s` can resolve sibling repositories on disk
- the local Core and Infra bundle identities are visible from the CLI
- the current checkout is wired consistently before a longer live run
