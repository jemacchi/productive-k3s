<!-- generated: playbooks-export-mkdocs -->
# Bundle Resolution Contract

Review the recorded CLI manifest contract that ties the CLI version to one Core bundle and one Infra bundle.

## Repository-local command

```bash
cd productive-k3s-cli
bash -lc 'tmp="$(mktemp -d)"; trap '"'"'"'"'"'"'"'"'rm -rf "$tmp"'"'"'"'"'"'"'"'"' EXIT; TEST_ARTIFACTS_DIR="$tmp" bash ./tests/contracts/02-bundle-resolution-contract.sh && cat "$tmp/bundle-resolution-contract.json"'
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/bundle-resolution-contract.cast" data-cast-title="Bundle Resolution Contract">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/bundle-resolution-contract.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-cli)
- [Open raw cast](../../../assets/playbooks/casts/cli/bundle-resolution-contract.cast)

## Scenario details

Review the recorded CLI manifest contract that ties the CLI version to one Core bundle and one Infra bundle.

Use this when you want a short proof that:

- the CLI manifest keeps Core and Infra bundle versions aligned
- the Infra bundle version carries the matching Core dependency suffix
- the bundle contract can be reviewed without running live infrastructure
