<!-- generated: playbooks-export-mkdocs -->
# CI Workflow Contract

Review the CI wiring contract for Go tests, CLI contracts, and the GitHub-host remote validator.

## Comando directo del repositorio

```bash
cd productive-k3s-cli
bash -lc 'tmp="$(mktemp -d)"; trap '"'"'"'"'"'"'"'"'rm -rf "$tmp"'"'"'"'"'"'"'"'"' EXIT; TEST_ARTIFACTS_DIR="$tmp" bash ./tests/contracts/07-ci-workflow-contract.sh && cat "$tmp/ci-workflow-contract.json"'
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/cli/ci-workflow-contract.cast" data-cast-title="CI Workflow Contract">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/cli/ci-workflow-contract.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-cli)
- [Abrir cast crudo](../../../assets/playbooks/casts/cli/ci-workflow-contract.cast)

## Detalle del escenario

Review the CI wiring contract for Go tests, CLI contracts, and the GitHub-host remote validator.

Use this when you want to review:

- that Go tests run before the CLI contract suite in CI
- that the workflow uses explicit bash steps
- that the remote on-prem GitHub-host validator remains wired into the CI contract
