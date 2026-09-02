<!-- generated: playbooks-export-mkdocs -->
# Validate Local Cluster

Run the standard post-apply validator against the local cluster.

## Repository-local command

```bash
cd productive-k3s-core
bash ./productive-k3s-core.sh validate --strict
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/validate-local-cluster.cast" data-cast-title="Validate Local Cluster">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/validate-local-cluster.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/validate-local-cluster.cast)

## Scenario details

## Goal

Run the standard post-apply validator against the local cluster.

## When to use it

- immediately after a successful `apply`
- after manual repair work
- before collecting a support snapshot or handing a cluster to another operator

## Prerequisites

- local checkout at `productive-k3s-core`
- local cluster already bootstrapped

## Expected result

- validator output with `OK`, `WARN`, and `FAIL` signals
- non-zero exit code if warnings or failures are found because this playbook uses `--strict`

## Notes

- the validator is the right next step after `apply`
- if registry coverage matters, a separate variant can later add `--docker-registry-test`
