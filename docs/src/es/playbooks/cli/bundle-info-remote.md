<!-- generated: playbooks-export-mkdocs -->
# Bundle Info Remote

Inspect published remote bundle resolution for both `core` and `infra` through `pk3s`.

## Comando directo del repositorio

```bash
cd productive-k3s-cli
bash -lc 'PRODUCTIVE_K3S_SOURCE=remote ./pk3s bundle core info --json && printf "\n" && PRODUCTIVE_K3S_SOURCE=remote ./pk3s bundle infra info --json'
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/bundle-info-remote.cast" data-cast-title="Bundle Info Remote">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/bundle-info-remote.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-cli)
- [Abrir cast crudo](../../../assets/playbooks/casts/cli/bundle-info-remote.cast)

## Detalle del escenario

Inspect published remote bundle resolution for both `core` and `infra` through `pk3s`.

Use this when you want a short proof that:

- the remote release resolution path is healthy
- `pk3s` can fetch published bundle metadata without doing an install
- the public bundle versions line up with what the CLI expects
