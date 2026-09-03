<!-- generated: playbooks-export-mkdocs -->
# Plan Profile Source Multipass

Preview the local `multipass` infrastructure plan from the source-oriented Infra workflow.

## Repository-local command

```bash
cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh plan --profile ../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/plan-profile-source-multipass.cast" data-cast-title="Plan Profile Source Multipass">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/plan-profile-source-multipass.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/plan-profile-source-multipass.cast)

## Scenario details

Preview the local `multipass` infrastructure plan from the source-oriented Infra workflow.

Use this when you want to inspect the OpenTofu-side plan for the default local multi-node profile before any mutating step.
