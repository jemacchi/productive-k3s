<!-- generated: playbooks-export-mkdocs -->
# Preflight Source Onprem Basic

Run the source-based `onprem-basic` preflight path through the profile-driven Infra CLI.

## Repository-local command

```bash
cd productive-k3s-profiles/scenarios/edge/onprem-basic
make preflight \
  ONPREM_ENV_FILE=/abs/path/to/onprem.env
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/preflight-source-onprem-basic.cast" data-cast-title="Preflight Source Onprem Basic">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/preflight-source-onprem-basic.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/preflight-source-onprem-basic.cast)

## Scenario details

Run the source-based `onprem-basic` preflight path through the profile-driven Infra CLI.

Optional environment:
```bash
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_SOURCE_PROFILE=/abs/path/to/onprem.env
```

Use a real environment-specific `onprem.env` when you want to execute this against reachable hosts. The default sibling profile is mainly there so the playbook remains inspectable and conventionally wired.
