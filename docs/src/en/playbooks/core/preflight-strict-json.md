<!-- generated: playbooks-export-mkdocs -->
# Preflight Strict JSON

Run host preflight in a CI- or automation-friendly mode where warnings also fail the run and output is machine-readable.

## Repository-local command

```bash
cd productive-k3s-core
bash ./productive-k3s-core.sh preflight --strict --json-output
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/preflight-strict-json.cast" data-cast-title="Preflight Strict JSON">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/preflight-strict-json.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/preflight-strict-json.cast)

## Scenario details

## Goal

Run host preflight in a CI- or automation-friendly mode where warnings also fail the run and output is machine-readable.

## When to use it

- you want to gate later automation on stricter host checks
- you need structured output for logs or pipelines
- you want to detect warning-level drift, not only blockers

## Prerequisites

- local checkout at `productive-k3s-core`
- supported Linux host or VM

## Expected result

- JSON object describing the check results
- non-zero exit code on warnings or failures
- no host changes

## Notes

- this is the better baseline for scripted operators than the human-readable variant
