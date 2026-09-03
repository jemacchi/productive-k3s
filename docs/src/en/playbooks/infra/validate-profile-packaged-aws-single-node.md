<!-- generated: playbooks-export-mkdocs -->
# Validate Profile Packaged AWS Single Node

Validate a packaged `aws-single-node` `profile.tgz` through the public Infra runtime surface.

## Repository-local command

```bash
cd productive-k3s-infra
bash ./productive-k3s-infra.sh profile validate --tgz "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ"
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/validate-profile-packaged-aws-single-node.cast" data-cast-title="Validate Profile Packaged AWS Single Node">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/validate-profile-packaged-aws-single-node.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/validate-profile-packaged-aws-single-node.cast)

## Scenario details

Validate a packaged `aws-single-node` `profile.tgz` through the public Infra runtime surface.

Required environment:
```bash
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ=/abs/path/to/aws-single-node-profile.tgz
```
