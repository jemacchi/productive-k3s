<!-- generated: playbooks-export-mkdocs -->
# Apply Dry Run Single Node

Preview the legacy all-in-one `single-node` path to understand how it differs from the preferred `server` mode.

## Repository-local command

```bash
cd productive-k3s-core
bash ./productive-k3s-core.sh apply --dry-run --mode single-node
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/apply-dry-run-single-node.cast" data-cast-title="Apply Dry Run Single Node">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/apply-dry-run-single-node.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/apply-dry-run-single-node.cast)

## Scenario details

## Goal

Preview the legacy all-in-one `single-node` path to understand how it differs from the preferred `server` mode.

## When to use it

- you need to compare old and new operator flows
- you are documenting mode differences
- you want a safe rehearsal of the legacy path

## Prerequisites

- local checkout at `productive-k3s-core`
- supported Linux host or VM

## Expected result

- dry-run plan for the legacy combined mode
- no persistent host changes

## Notes

- `single-node` remains useful as a reference path
- current public guidance still prefers `apply --mode server` plus later explicit stack work
