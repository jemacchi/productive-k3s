<!-- generated: playbooks-export-mkdocs -->
# Bundle Info And BOM

Inspect what the `core` CLI bundle is, which runtime files it carries, and which component versions it pins.

## Repository-local command

```bash
bash ./productive-k3s-core.sh bundle info --json
bash ./productive-k3s-core.sh bom --json
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/bundle-info-and-bom.cast" data-cast-title="Bundle Info And BOM">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/bundle-info-and-bom.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/bundle-info-and-bom.cast)

## Scenario details

## Goal

Inspect what the `core` CLI bundle is, which runtime files it carries, and which component versions it pins.

## When to use it

- you want to understand what a checkout or bundle will run
- you are validating release contents before distribution
- you need the pinned component versions for debugging or documentation

## Prerequisites

- local checkout at `productive-k3s-core`

## Expected result

- JSON bundle metadata
- JSON BOM describing the pinned runtime/component versions
- no host changes and no telemetry prompt

## Notes

- these commands are read-only and are good candidates for demos and release review
