<!-- generated: playbooks-export-mkdocs -->
# Infra Command Mapping Review

Review the expected CLI-to-Infra and CLI-to-profile command delegation map.

## Repository-local command

```bash
cd productive-k3s-cli
bash -lc 'tmp="$(mktemp -d)"; trap '"'"'"'"'"'"'"'"'rm -rf "$tmp"'"'"'"'"'"'"'"'"' EXIT; TEST_ARTIFACTS_DIR="$tmp" bash ./tests/contracts/04-infra-command-mapping-contract.sh && cat "$tmp/infra-command-mapping-contract.json"'
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/infra-command-mapping-review.cast" data-cast-title="Infra Command Mapping Review">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/infra-command-mapping-review.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-cli)
- [Open raw cast](../../../assets/playbooks/casts/cli/infra-command-mapping-review.cast)

## Scenario details

Review the expected CLI-to-Infra and CLI-to-profile command delegation map.

Use this when you want to show:

- which `pk3s` profile and infra commands delegate into `productive-k3s-infra.sh`
- where catalog-backed lookups stop short of Infra bundle delegation
- the expected mappings for `plan`, `apply`, `destroy`, `status`, `install`, and `export`
