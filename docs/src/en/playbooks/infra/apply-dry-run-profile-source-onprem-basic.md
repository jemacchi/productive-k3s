<!-- generated: playbooks-export-mkdocs -->
# Apply Dry Run Profile Source Onprem Basic

Preview the source-based `onprem-basic` apply path in dry-run mode.

## Repository-local command

```bash
cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh apply --profile ../productive-k3s-profiles/profiles/edge/on-prem/basic.env --dry-run
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/apply-dry-run-profile-source-onprem-basic.cast" data-cast-title="Apply Dry Run Profile Source Onprem Basic">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/apply-dry-run-profile-source-onprem-basic.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/apply-dry-run-profile-source-onprem-basic.cast)

## Scenario details

Preview the source-based `onprem-basic` apply path in dry-run mode.

Optional environment:
```bash
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_SOURCE_PROFILE=/abs/path/to/onprem.env
```

Use this when you want to review the apply lifecycle shape for `onprem-basic` without touching the remote hosts.
