<!-- generated: playbooks-export-mkdocs -->
# Validate Profile Source Onprem Basic

Validate the public `onprem-basic` source profile contract from the sibling `productive-k3s-profiles` checkout.

## Repository-local command

```bash
cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh validate-profile --profile ../productive-k3s-profiles/profiles/edge/on-prem/basic.env
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/validate-profile-source-onprem-basic.cast" data-cast-title="Validate Profile Source Onprem Basic">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/validate-profile-source-onprem-basic.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/validate-profile-source-onprem-basic.cast)

## Scenario details

Validate the public `onprem-basic` source profile contract from the sibling `productive-k3s-profiles` checkout.

Use this when you want a fast contract check for the most representative SSH/on-prem public profile without launching remote work.
