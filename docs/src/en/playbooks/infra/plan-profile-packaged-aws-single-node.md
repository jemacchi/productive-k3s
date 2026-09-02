<!-- generated: playbooks-export-mkdocs -->
# Plan Profile Packaged AWS Single Node

Preview the package-first OpenTofu plan for an `aws-single-node` `profile.tgz`.

## Repository-local command

```bash
cd productive-k3s-infra
bash ./productive-k3s-infra.sh profile plan \
  --tgz "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ" \
  --env-file "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_ENV_FILE"
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/plan-profile-packaged-aws-single-node.cast" data-cast-title="Plan Profile Packaged AWS Single Node">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/plan-profile-packaged-aws-single-node.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/plan-profile-packaged-aws-single-node.cast)

## Scenario details

Preview the package-first OpenTofu plan for an `aws-single-node` `profile.tgz`.

Required environment:
```bash
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ=/abs/path/to/aws-single-node-profile.tgz
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_ENV_FILE=/abs/path/to/aws.env
```

This playbook documents the public cloud plan contract even when the resulting real execution depends on valid AWS credentials and network access.
