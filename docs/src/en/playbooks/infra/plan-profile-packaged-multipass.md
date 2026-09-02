<!-- generated: playbooks-export-mkdocs -->
# Plan Profile Packaged Multipass

Preview the package-first OpenTofu plan for a packaged `multipass` `profile.tgz`.

## Repository-local command

```bash
cd productive-k3s-infra
./productive-k3s-infra.sh profile plan --tgz /abs/path/to/multipass-profile.tgz
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/plan-profile-packaged-multipass.cast" data-cast-title="Plan Profile Packaged Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/plan-profile-packaged-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/plan-profile-packaged-multipass.cast)

## Scenario details

Preview the package-first OpenTofu plan for a packaged `multipass` `profile.tgz`.

```bash
PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ=/abs/path/to/multipass-profile.tgz \
```

Use this when you want to demonstrate the public package-first planning path for an OpenTofu-backed local topology without mutating infrastructure yet.
