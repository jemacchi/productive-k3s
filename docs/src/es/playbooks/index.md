<!-- generated: playbooks-export-mkdocs -->
# Playbooks

Ejemplos ejecutables con casts reales, comandos directos y notas de escenario para el ecosistema Productive K3S.

## Explorar por producto

- [Addons](addons/index.md): 8 escenarios
- [Cli](cli/index.md): 15 escenarios
- [Core](core/index.md): 25 escenarios
- [Infra](infra/index.md): 27 escenarios
- [Profiles](profiles/index.md): 13 escenarios

## Ejemplos destacados

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">ADDONS</div>
  <h3><a href="addons/addon-contract-nginx-with-core/">Addon Contract Nginx With Core</a></h3>
  <p>Cross-check the `nginx` add-on source package against the current `productive-k3s-core` source validation contract.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-addons
ADDON=nginx PRODUCTIVE_K3S_CORE_REPO_DIR=../productive-k3s-core make -C ./tests test-contract</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">ADDONS</div>
  <h3><a href="addons/addon-impact-metadata-review/">Addon Impact Metadata Review</a></h3>
  <p>Review the impact metadata that tells `core` and operators which add-ons imply cluster-local or host-local changes.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>$\n  for addon in addons/*;
do\n    [[ -f "${addon}/addon.yaml" ]] || continue\n    name="$(basename "${addon}")"\n    cluster="$(awk "/^spec:/{in_spec=1;
next} in_spec &amp;&amp; /^  impact:/{in_impact=1;
next} in_impact &amp;&amp; /^    cluster:/{sub(/^    cluster:[[:space:]]*/, \\"\\", \\$0);
print;
exit}" "${addon}/addon.yaml")"\n    host="$(awk "/^spec:/{in_spec=1;
next} in_spec &amp;&amp; /^  impact:/{in_impact=1;
next} in_impact &amp;&amp; /^    host:/{sub(/^    host:[[:space:]]*/, \\"\\", \\$0);
print;
exit}" "${addon}/addon.yaml")"\n    summary="$(awk "/^spec:/{in_spec=1;
next} in_spec &amp;&amp; /^  impact:/{in_impact=1;
next} in_impact &amp;&amp; /^    summary:/{sub(/^    summary:[[:space:]]*/, \\"\\", \\$0);
print;
exit}" "${addon}/addon.yaml")"\n    printf "%s|cluster=%s|host=%s|summary=%s\\n" "${name}" "${cluster}" "${host}" "${summary}"\n  done | sort\n</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="cli/addon-list-basic/">Addon List Basic</a></h3>
  <p>Review the catalog-backed addon listing exposed by `pk3s`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash -lc './pk3s addon list'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="cli/bundle-info-local/">Bundle Info Local</a></h3>
  <p>Inspect local sibling bundle resolution for both `core` and `infra` through `pk3s`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash -lc 'PRODUCTIVE_K3S_SOURCE=local ./pk3s bundle core info --json &amp;&amp; printf "\n" &amp;&amp; PRODUCTIVE_K3S_SOURCE=local ./pk3s bundle infra info --json'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="core/addon-install-packaged-public-host/">Addon Install Packaged Public Host</a></h3>
  <p>Install a packaged addon and request a basic public ingress host.</p>
  
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="core/addon-validate-package/">Addon Validate Package</a></h3>
  <p>Validate an addon package before installation.</p>
  
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="infra/apply-dry-run-profile-source-multipass/">Apply Dry Run Profile Source Multipass</a></h3>
  <p>Show the local `multipass` apply path in dry-run mode from the source-oriented Infra workflow.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh apply --dry-run --profile ../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="infra/apply-dry-run-profile-source-onprem-basic/">Apply Dry Run Profile Source Onprem Basic</a></h3>
  <p>Preview the source-based `onprem-basic` apply path in dry-run mode.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh apply --profile ../productive-k3s-profiles/profiles/edge/on-prem/basic.env --dry-run</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="profiles/live-matrix/">Live Matrix</a></h3>
  <p>Run the full live matrix across every discovered public `profiles` scenario.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-live-matrix</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="profiles/live-multipass/">Live Multipass</a></h3>
  <p>Run the live `multipass` scenario validation path from the `productive-k3s-profiles` source checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
SCENARIO=multipass PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-live</code></pre></div>
</article>
