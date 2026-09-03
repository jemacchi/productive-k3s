<!-- generated: playbooks-export-mkdocs -->
# Export Profile Packaged Multipass

Export a packaged `multipass` `profile.tgz` into a self-contained installer bundle.

## Comando directo del repositorio

```bash
cd productive-k3s-infra
./productive-k3s-infra.sh profile export \
  --tgz /abs/path/to/multipass-profile.tgz \
  --output /tmp/multipass-installer
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/export-profile-packaged-multipass.cast" data-cast-title="Export Profile Packaged Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/export-profile-packaged-multipass.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/export-profile-packaged-multipass.cast)

## Detalle del escenario

Export a packaged `multipass` `profile.tgz` into a self-contained installer bundle.

```bash
PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ=/abs/path/to/multipass-profile.tgz \
PRODUCTIVE_K3S_INFRA_PLAYBOOK_EXPORT_OUTPUT=/tmp/multipass-installer \
```

Preparation note:

- this playbook intentionally expects a local `.tgz` artifact path
- use an explicit output path so the generated installer bundle is easy to inspect or remove afterward

Use this when you want the cleanest package-first proof that Infra can turn a chosen profile artifact into a portable installer bundle.
