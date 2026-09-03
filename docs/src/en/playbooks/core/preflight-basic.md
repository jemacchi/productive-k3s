<!-- generated: playbooks-export-mkdocs -->
# Preflight Basic

Run the standard host compatibility check from a local `productive-k3s-core` checkout before attempting any installation.

## Repository-local command

```bash
cd productive-k3s-core
bash ./productive-k3s-core.sh preflight
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/preflight-basic.cast" data-cast-title="Preflight Basic">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/preflight-basic.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/preflight-basic.cast)

## Scenario details

## Goal

Run the standard host compatibility check from a local `productive-k3s-core` checkout before attempting any installation.

## When to use it

- you have the repository checked out locally
- you want a fast human-readable yes/no signal
- you are validating a fresh VM or host before `apply`

## Prerequisites

- local checkout at `productive-k3s-core`
- supported Linux host or VM
- basic host commands expected by `core`

## Expected result

- `OK`, `WARN`, and `FAIL` lines summarizing platform, command, and hardware checks
- exit code `0` when there are no blockers
- no host changes

## Notes

- warnings do not fail this basic variant
- use `preflight-strict-json` when automation needs machine-readable output
