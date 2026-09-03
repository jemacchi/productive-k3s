<!-- generated: playbooks-export-mkdocs -->
# Export Profile Source Multipass

Export the source `multipass` profile into a self-contained installer bundle.

## Comando directo del repositorio

```bash
cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh export \
    --profile ../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env \
    --output /tmp/infra-source-export
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/export-profile-source-multipass.cast" data-cast-title="Export Profile Source Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/export-profile-source-multipass.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/export-profile-source-multipass.cast)

## Detalle del escenario

Export the source `multipass` profile into a self-contained installer bundle.

```bash
PRODUCTIVE_K3S_INFRA_PLAYBOOK_EXPORT_OUTPUT=/tmp/infra-source-export \
```

Use this when you want to show that the source-oriented development surface normalizes into the same self-contained installer contract as the public package-first flows.
