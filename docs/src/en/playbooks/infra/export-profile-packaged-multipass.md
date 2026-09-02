<!-- generated: playbooks-export-mkdocs -->
# Export Profile Packaged Multipass

Export a packaged `multipass` `profile.tgz` into a self-contained installer bundle.

## Repository-local command

```bash
cd productive-k3s-infra
./productive-k3s-infra.sh profile export \
  --tgz /abs/path/to/multipass-profile.tgz \
  --output /tmp/multipass-installer
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/export-profile-packaged-multipass.cast" data-cast-title="Export Profile Packaged Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/export-profile-packaged-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/export-profile-packaged-multipass.cast)

## Scenario details

Export a packaged `multipass` `profile.tgz` into a self-contained installer bundle.

```bash
PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ=/abs/path/to/multipass-profile.tgz \
PRODUCTIVE_K3S_INFRA_PLAYBOOK_EXPORT_OUTPUT=/tmp/multipass-installer \
```

Preparation note:

- this playbook intentionally expects a local `.tgz` artifact path
- use an explicit output path so the generated installer bundle is easy to inspect or remove afterward

Use this when you want the cleanest package-first proof that Infra can turn a chosen profile artifact into a portable installer bundle.
