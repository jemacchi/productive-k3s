<!-- generated: playbooks-export-mkdocs -->
# Destroy Profile Packaged AWS Single Node

Destroy the package-first `aws-single-node` runtime through the public Infra profile lifecycle.

## Repository-local command

```bash
cd productive-k3s-infra
bash ./productive-k3s-infra.sh profile destroy \
  --tgz "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ" \
  --env-file "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_ENV_FILE"
```

## Cast preview

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/destroy-profile-packaged-aws-single-node.cast" data-cast-title="Destroy Profile Packaged AWS Single Node">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/destroy-profile-packaged-aws-single-node.cast">Open raw cast</a>
  </div>
</div>

## Related links

- [Product repository](https://github.com/productive-k3s/productive-k3s-infra)
- [Open raw cast](../../../assets/playbooks/casts/infra/destroy-profile-packaged-aws-single-node.cast)

## Scenario details

Destroy the package-first `aws-single-node` runtime through the public Infra profile lifecycle.

Required environment:
```bash
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ=/abs/path/to/aws-single-node-profile.tgz
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_ENV_FILE=/abs/path/to/aws.env
```

Use this as the cloud teardown counterpart of the package-first lifecycle once a real AWS-backed runtime state exists.
