<!-- generated: playbooks-export-mkdocs -->
# CI Workflow Contract

Review the CI wiring contract for Go tests, CLI contracts, and the GitHub-host remote validator.

## Repository-local command

```bash
cd productive-k3s-cli
bash -lc 'tmp="$(mktemp -d)"; trap '"'"'"'"'"'"'"'"'rm -rf "$tmp"'"'"'"'"'"'"'"'"' EXIT; TEST_ARTIFACTS_DIR="$tmp" bash ./tests/contracts/07-ci-workflow-contract.sh && cat "$tmp/ci-workflow-contract.json"'
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/ci-workflow-contract.cast" data-cast-title="CI Workflow Contract">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/ci-workflow-contract.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-cli)
- [Open raw cast](../../../assets/playbooks/casts/cli/ci-workflow-contract.cast)

## Scenario details

Review the CI wiring contract for Go tests, CLI contracts, and the GitHub-host remote validator.

Use this when you want to review:

- that Go tests run before the CLI contract suite in CI
- that the workflow uses explicit bash steps
- that the remote on-prem GitHub-host validator remains wired into the CI contract
