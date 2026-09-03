<!-- generated: playbooks-export-mkdocs -->
# Addon Contract Nginx With Core

Cross-check the `nginx` add-on source package against the current `productive-k3s-core` source validation contract.

## Repository-local command

```bash
cd productive-k3s-addons
ADDON=nginx PRODUCTIVE_K3S_CORE_REPO_DIR=../productive-k3s-core make -C ./tests test-contract
```

## Cast preview

<div class="pk3s-playbook-cast-empty">
  <p>No canonical cast is published for this playbook yet.</p>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-addons)

## Scenario details

## Goal

Cross-check the `nginx` add-on source package against the current `productive-k3s-core` source validation contract.

## When to use it

- when `core` changed its add-on contract
- before releasing a new `nginx` source package revision
- when validating `addons` and `core` together on `development`

## Prerequisites

- local checkout at `productive-k3s-addons`
- local checkout at `productive-k3s-core`

## Expected result

- `core` accepts the `nginx` source package as valid input for its development-side source validator
- no live cluster installation
