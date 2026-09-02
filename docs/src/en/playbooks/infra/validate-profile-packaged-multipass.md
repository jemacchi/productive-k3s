<!-- generated: playbooks-export-mkdocs -->
# Validate Profile Packaged Multipass

Validate a packaged `multipass` `profile.tgz` through the public Infra runtime surface.

## Repository-local command

```bash
cd productive-k3s-infra
./productive-k3s-infra.sh profile validate --tgz /abs/path/to/multipass-profile.tgz
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/validate-profile-packaged-multipass.cast" data-cast-title="Validate Profile Packaged Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/validate-profile-packaged-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/validate-profile-packaged-multipass.cast)

## Scenario details

Validate a packaged `multipass` `profile.tgz` through the public Infra runtime surface.

```bash
PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ=/abs/path/to/multipass-profile.tgz \
```

Preparation note:

- this playbook intentionally expects a local `.tgz` artifact path
- do not hardcode a release URL here; the artifact version should be chosen explicitly by the maintainer

Use this when you want to exercise the public package-first contract without relying on source profiles.
