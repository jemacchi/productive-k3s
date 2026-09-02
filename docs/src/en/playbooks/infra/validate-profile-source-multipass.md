<!-- generated: playbooks-export-mkdocs -->
# Validate Profile Source Multipass

Validate the public local `multipass` source profile contract from the sibling `productive-k3s-profiles` checkout.

## Repository-local command

```bash
cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh validate-profile --profile ../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/validate-profile-source-multipass.cast" data-cast-title="Validate Profile Source Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/validate-profile-source-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/validate-profile-source-multipass.cast)

## Scenario details

Validate the public local `multipass` source profile contract from the sibling `productive-k3s-profiles` checkout.

Use this when you want the simplest source-level validation for the local multi-node profile before planning or applying it.
