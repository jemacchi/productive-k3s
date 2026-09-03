<!-- generated: playbooks-export-mkdocs -->
# Validate Static Multipass

Run the `multipass` static validation path from the `productive-k3s-profiles` source checkout.

## Repository-local command

```bash
cd productive-k3s-profiles
SCENARIO=multipass PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-static
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/profiles/validate-static-multipass.cast" data-cast-title="Validate Static Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/profiles/validate-static-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-profiles)
- [Open raw cast](../../../assets/playbooks/casts/profiles/validate-static-multipass.cast)

## Scenario details

Run the `multipass` static validation path from the `productive-k3s-profiles` source checkout.

Use this when you want the shortest meaningful proof that the local multi-node scenario still validates against the current Infra development surface.
