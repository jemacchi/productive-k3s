<!-- generated: playbooks-export-mkdocs -->
# Artifact Review Exported Multipass K3sup

Export a source-based `multipass` installer bundle with `PRODUCTIVE_K3S_ENGINE=k3sup` and inspect the resulting artifact layout plus embedded `profile.env`.

## Comando directo del repositorio

```bash
cd productive-k3s-infra
set -euo pipefail;
rm -rf "/tmp/infra-export";
PRODUCTIVE_K3S_PROFILES_REPO_DIR="../productive-k3s-profiles" PRODUCTIVE_K3S_ENGINE=k3sup bash ./productive-k3s-infra.sh export --profile "../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env" --output "/tmp/infra-export" >/dev/null;
find "/tmp/infra-export" -maxdepth 2 -type f | sort;
printf '\n';
printf '%s\n' '--- profile.tgz entries ---';
tar -tzf "/tmp/infra-export/profile.tgz" | sort;
printf '\n';
printf '%s\n' '--- embedded profile.env ---';
tar -xOf "/tmp/infra-export/profile.tgz" ./profile.env
```

## Vista del cast

<div class="pk3s-playbook-cast" data-cast-src="../../../../assets/playbooks/casts/infra/artifact-review-exported-multipass-k3sup.cast" data-cast-title="Artifact Review Exported Multipass K3sup">
  <div class="pk3s-playbook-cast__player"></div>
  <div class="pk3s-playbook-cast__fallback" hidden>
    <a href="../../../../assets/playbooks/casts/infra/artifact-review-exported-multipass-k3sup.cast">Abrir cast crudo</a>
  </div>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-infra)
- [Abrir cast crudo](../../../assets/playbooks/casts/infra/artifact-review-exported-multipass-k3sup.cast)

## Detalle del escenario

Export a source-based `multipass` installer bundle with `PRODUCTIVE_K3S_ENGINE=k3sup` and inspect the resulting artifact layout plus embedded `profile.env`.

Use this when you want visual proof that the exported artifact still carries the engine selection inside the packaged profile contract.
