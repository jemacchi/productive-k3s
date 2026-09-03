<!-- generated: playbooks-export-mkdocs -->
# Core Command Mapping Review

Review the expected CLI-to-Core command delegation map.

## Repository-local command

```bash
cd productive-k3s-cli
bash -lc 'tmp="$(mktemp -d)"; trap '"'"'"'"'"'"'"'"'rm -rf "$tmp"'"'"'"'"'"'"'"'"' EXIT; TEST_ARTIFACTS_DIR="$tmp" bash ./tests/contracts/03-core-command-mapping-contract.sh && cat "$tmp/core-command-mapping-contract.json"'
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/core-command-mapping-review.cast" data-cast-title="Core Command Mapping Review">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/core-command-mapping-review.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-cli)
- [Open raw cast](../../../assets/playbooks/casts/cli/core-command-mapping-review.cast)

## Scenario details

Review the expected CLI-to-Core command delegation map.

Use this when you want to show:

- which user-facing `pk3s` commands delegate into `productive-k3s-core.sh`
- that the contract is reviewed from a generated artifact, not by hand
- the expected bundle-info, addon, stack, install, validate, and backup mappings
