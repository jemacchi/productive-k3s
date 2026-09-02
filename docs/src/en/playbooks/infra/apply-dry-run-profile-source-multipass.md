<!-- generated: playbooks-export-mkdocs -->
# Apply Dry Run Profile Source Multipass

Show the local `multipass` apply path in dry-run mode from the source-oriented Infra workflow.

## Repository-local command

```bash
cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh apply --dry-run --profile ../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/apply-dry-run-profile-source-multipass.cast" data-cast-title="Apply Dry Run Profile Source Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/apply-dry-run-profile-source-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/apply-dry-run-profile-source-multipass.cast)

## Scenario details

Show the local `multipass` apply path in dry-run mode from the source-oriented Infra workflow.

Use this when you want a higher-level preview than `plan`, but still without creating instances or mutating local state.
