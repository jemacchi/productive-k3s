<!-- generated: playbooks-export-mkdocs -->
# Exported Installer RKE2 Ubuntu24

Validate the self-contained exported base installer on Ubuntu 24.04 with `PRODUCTIVE_K3S_DISTRO=rke2`.

## Comando directo del repositorio

```bash
cd productive-k3s-core
make -C ./tests test-exported-stack-installer-rke2-ubuntu24
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/core/exported-installer-rke2-ubuntu24.cast" data-cast-title="Exported Installer RKE2 Ubuntu24">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/core/exported-installer-rke2-ubuntu24.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-core)
- [Abrir cast crudo](../../../assets/playbooks/casts/core/exported-installer-rke2-ubuntu24.cast)

## Detalle del escenario

Validate the self-contained exported base installer on Ubuntu 24.04 with `PRODUCTIVE_K3S_DISTRO=rke2`.

Use this when you need proof that the exported installer bundle still works without a staged Productive K3S source checkout and with the `rke2` distro contract frozen into the bundle.
