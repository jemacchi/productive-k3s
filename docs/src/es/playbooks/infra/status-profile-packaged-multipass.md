<!-- generated: playbooks-export-mkdocs -->
# Status Profile Packaged Multipass

Show the packaged runtime status for a `multipass` `profile.tgz` after a prior package-first plan or install.

## Comando directo del repositorio

```bash
cd productive-k3s-infra
bash ./productive-k3s-infra.sh profile status --tgz "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ"
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/status-profile-packaged-multipass.cast" data-cast-title="Status Profile Packaged Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/status-profile-packaged-multipass.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/status-profile-packaged-multipass.cast)

## Detalle del escenario

Show the packaged runtime status for a `multipass` `profile.tgz` after a prior package-first plan or install.

Required environment:
```bash
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ=/abs/path/to/multipass-profile.tgz
```

Use this when you want to inspect the persisted package-first runtime contract after an earlier `plan`, `install`, or `apply`.
