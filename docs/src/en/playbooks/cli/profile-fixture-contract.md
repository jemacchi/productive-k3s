<!-- generated: playbooks-export-mkdocs -->
# Profile Fixture Contract

Review the profile fixture contract used by CLI command tests.

## Repository-local command

```bash
cd productive-k3s-cli
bash -lc 'tmp="$(mktemp -d)"; trap '"'"'"'"'"'"'"'"'rm -rf "$tmp"'"'"'"'"'"'"'"'"' EXIT; TEST_ARTIFACTS_DIR="$tmp" bash ./tests/contracts/05-profile-command-contract.sh && cat "$tmp/profile-command-contract.json"'
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/profile-fixture-contract.cast" data-cast-title="Profile Fixture Contract">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/profile-fixture-contract.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-cli)
- [Open raw cast](../../../assets/playbooks/casts/cli/profile-fixture-contract.cast)

## Scenario details

Review the profile fixture contract used by CLI command tests.

Use this when you want to confirm that:

- the fixture used by CLI command tests contains the required Infra contract variables
- the engine field is constrained to the supported values
- the test surface is grounded in a concrete checked-in profile fixture
