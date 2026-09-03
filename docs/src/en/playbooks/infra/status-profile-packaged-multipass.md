<!-- generated: playbooks-export-mkdocs -->
# Status Profile Packaged Multipass

Show the packaged runtime status for a `multipass` `profile.tgz` after a prior package-first plan or install.

## Repository-local command

```bash
cd productive-k3s-infra
bash ./productive-k3s-infra.sh profile status --tgz "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ"
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/status-profile-packaged-multipass.cast" data-cast-title="Status Profile Packaged Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/status-profile-packaged-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/status-profile-packaged-multipass.cast)

## Scenario details

Show the packaged runtime status for a `multipass` `profile.tgz` after a prior package-first plan or install.

Required environment:
```bash
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ=/abs/path/to/multipass-profile.tgz
```

Use this when you want to inspect the persisted package-first runtime contract after an earlier `plan`, `install`, or `apply`.
