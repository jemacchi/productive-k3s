<!-- generated: playbooks-export-mkdocs -->
# Doctor Basic

Run the shortest local operator-facing environment sanity check for `productive-k3s-infra`.

## Comando directo del repositorio

```bash
cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles bash ./productive-k3s-infra.sh doctor
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/doctor-basic.cast" data-cast-title="Doctor Basic">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/doctor-basic.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/doctor-basic.cast)

## Detalle del escenario

Run the shortest local operator-facing environment sanity check for `productive-k3s-infra`.

This default maintainer path automatically wires the sibling `productive-k3s-profiles` checkout when it exists, so the doctor output stays focused on real missing prerequisites rather than an avoidable source-profile warning.

Use this when you want a quick shell-level confirmation that the local Infra CLI prerequisites are visible before moving to profile-specific flows.

If you want to review the explicit warning path instead, use [`doctor-without-profiles-warning`](./doctor-without-profiles-warning.md).
