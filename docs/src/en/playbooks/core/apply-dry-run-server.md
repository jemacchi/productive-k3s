<!-- generated: playbooks-export-mkdocs -->
# Apply Dry Run Server

Preview the preferred `core` installation path without changing the host.

## Repository-local command

```bash
cd productive-k3s-core
bash ./productive-k3s-core.sh apply --dry-run --mode server
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/apply-dry-run-server.cast" data-cast-title="Apply Dry Run Server">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/apply-dry-run-server.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/apply-dry-run-server.cast)

## Scenario details

## Goal

Preview the preferred `core` installation path without changing the host.

## When to use it

- you want to see the base installation plan before applying
- you want to confirm the difference between `preflight` and the actual bootstrap flow
- you are preparing an operator demo that should not mutate the machine

## Prerequisites

- local checkout at `productive-k3s-core`
- supported Linux host or VM
- successful preflight is recommended first

## Expected result

- plan-oriented output describing what `core` would install or reuse
- possible prompts that influence the plan
- no persistent host changes

## Notes

- `server` is the preferred public contract for core-only installation
- this playbook is safer than testing the real apply path when the host is not disposable
