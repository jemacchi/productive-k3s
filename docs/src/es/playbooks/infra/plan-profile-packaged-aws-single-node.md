<!-- generated: playbooks-export-mkdocs -->
# Plan Profile Packaged AWS Single Node

Preview the package-first OpenTofu plan for an `aws-single-node` `profile.tgz`.

## Comando directo del repositorio

```bash
cd productive-k3s-infra
bash ./productive-k3s-infra.sh profile plan \
  --tgz "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ" \
  --env-file "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_ENV_FILE"
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/plan-profile-packaged-aws-single-node.cast" data-cast-title="Plan Profile Packaged AWS Single Node">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/plan-profile-packaged-aws-single-node.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/plan-profile-packaged-aws-single-node.cast)

## Detalle del escenario

Preview the package-first OpenTofu plan for an `aws-single-node` `profile.tgz`.

Required environment:
```bash
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ=/abs/path/to/aws-single-node-profile.tgz
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_ENV_FILE=/abs/path/to/aws.env
```

This playbook documents the public cloud plan contract even when the resulting real execution depends on valid AWS credentials and network access.
