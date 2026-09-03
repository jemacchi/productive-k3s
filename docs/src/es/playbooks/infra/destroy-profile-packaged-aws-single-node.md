<!-- generated: playbooks-export-mkdocs -->
# Destroy Profile Packaged AWS Single Node

Destroy the package-first `aws-single-node` runtime through the public Infra profile lifecycle.

## Comando directo del repositorio

```bash
cd productive-k3s-infra
bash ./productive-k3s-infra.sh profile destroy \
  --tgz "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ" \
  --env-file "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_ENV_FILE"
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/destroy-profile-packaged-aws-single-node.cast" data-cast-title="Destroy Profile Packaged AWS Single Node">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/destroy-profile-packaged-aws-single-node.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/destroy-profile-packaged-aws-single-node.cast)

## Detalle del escenario

Destroy the package-first `aws-single-node` runtime through the public Infra profile lifecycle.

Required environment:
```bash
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ=/abs/path/to/aws-single-node-profile.tgz
export PRODUCTIVE_K3S_INFRA_PLAYBOOK_ENV_FILE=/abs/path/to/aws.env
```

Use this as the cloud teardown counterpart of the package-first lifecycle once a real AWS-backed runtime state exists.
