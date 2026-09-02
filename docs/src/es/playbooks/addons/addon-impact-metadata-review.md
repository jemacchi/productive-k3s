<!-- generated: playbooks-export-mkdocs -->
# Addon Impact Metadata Review

Review the impact metadata that tells `core` and operators which add-ons imply cluster-local or host-local changes.

## Comando directo del repositorio

```bash
$\n  for addon in addons/*;
do\n    [[ -f "${addon}/addon.yaml" ]] || continue\n    name="$(basename "${addon}")"\n    cluster="$(awk "/^spec:/{in_spec=1;
next} in_spec && /^  impact:/{in_impact=1;
next} in_impact && /^    cluster:/{sub(/^    cluster:[[:space:]]*/, \\"\\", \\$0);
print;
exit}" "${addon}/addon.yaml")"\n    host="$(awk "/^spec:/{in_spec=1;
next} in_spec && /^  impact:/{in_impact=1;
next} in_impact && /^    host:/{sub(/^    host:[[:space:]]*/, \\"\\", \\$0);
print;
exit}" "${addon}/addon.yaml")"\n    summary="$(awk "/^spec:/{in_spec=1;
next} in_spec && /^  impact:/{in_impact=1;
next} in_impact && /^    summary:/{sub(/^    summary:[[:space:]]*/, \\"\\", \\$0);
print;
exit}" "${addon}/addon.yaml")"\n    printf "%s|cluster=%s|host=%s|summary=%s\\n" "${name}" "${cluster}" "${host}" "${summary}"\n  done | sort\n
```

## Vista del cast

<div class="pk3s-playbook-cast-empty">
  <p>Todavía no hay un cast canónico publicado para este playbook.</p>
</div>

## Enlaces relacionados

- [Repositorio del producto](https://github.com/productive-k3s/productive-k3s-addons)

## Detalle del escenario

## Goal

Review the impact metadata that tells `core` and operators which add-ons imply cluster-local or host-local changes.

## When to use it

- when discussing preflight or apply warnings
- after editing `spec.impact.*` metadata in one or more add-ons
- when you want a fast documentation-oriented inventory of the public catalog

## Prerequisites

- local checkout at `productive-k3s-addons`

## Expected result

- one summarized line per public add-on
- visible `cluster`, `host`, and `summary` declarations
- no host or cluster mutations
