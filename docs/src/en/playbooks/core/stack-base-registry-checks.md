<!-- generated: playbooks-export-mkdocs -->
# Stack Base Registry Checks

Validate registry behavior after `base` is installed.

## Repository-local command

```bash
bash ./productive-k3s-core.sh validate --strict --docker-registry-test
bash -lc curl\ -kI\ https://registry.home.arpa/v2/
bash -lc curl\ -k\ https://registry.home.arpa/v2/_catalog\ \|\ jq
bash ./utils/list-registry-images.sh --json
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/stack-base-registry-checks.cast" data-cast-title="Stack Base Registry Checks">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/stack-base-registry-checks.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-core)
- [Open raw cast](../../../assets/playbooks/casts/core/stack-base-registry-checks.cast)

## Scenario details

Validate registry behavior after `base` is installed.

This includes:

- `validate --strict --docker-registry-test`
- registry endpoint probes
- registry inventory helper output
