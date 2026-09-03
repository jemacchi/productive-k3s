<!-- generated: playbooks-export-mkdocs -->
# Export Profile Source Multipass K3sup

Export the source-based `multipass` profile into a self-contained installer bundle while forcing `PRODUCTIVE_K3S_ENGINE=k3sup`.

## Comando directo del repositorio

```bash
cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
PRODUCTIVE_K3S_ENGINE=k3sup \
  bash ./productive-k3s-infra.sh export --profile ../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env --output /tmp/infra-k3sup-export
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/export-profile-source-multipass-k3sup.cast" data-cast-title="Export Profile Source Multipass K3sup">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/export-profile-source-multipass-k3sup.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/export-profile-source-multipass-k3sup.cast)

## Detalle del escenario

Export the source-based `multipass` profile into a self-contained installer bundle while forcing `PRODUCTIVE_K3S_ENGINE=k3sup`.

Optional environment:
```bash
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_EXPORT_OUTPUT=/tmp/infra-k3sup-export
```
