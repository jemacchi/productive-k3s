<!-- generated: playbooks-export-mkdocs -->
# Addons Playbooks

Escenarios: 8

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">ADDONS</div>
  <h3><a href="./addon-contract-nginx-with-core/">Addon Contract Nginx With Core</a></h3>
  <p>Cross-check the `nginx` add-on source package against the current `productive-k3s-core` source validation contract.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-addons
ADDON=nginx PRODUCTIVE_K3S_CORE_REPO_DIR=../productive-k3s-core make -C ./tests test-contract</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">ADDONS</div>
  <h3><a href="./addon-impact-metadata-review/">Addon Impact Metadata Review</a></h3>
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
  <div class="pk3s-playbook-card__eyebrow">ADDONS</div>
  <h3><a href="./addon-public-host-nginx/">Addon Public Host Nginx</a></h3>
  <p>Exercise the `nginx` live install path that uses the narrow public-host exposure contract consumed by `core`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-addons
ADDON=nginx PRODUCTIVE_K3S_CORE_REPO_DIR=../productive-k3s-core PK3S_ADDON_PUBLIC_HOST=nginx-01.k3s.lab.internal make -C ./tests test-live</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">ADDONS</div>
  <h3><a href="./addon-validate-nginx-package/">Addon Validate Nginx Package</a></h3>
  <p>Validate the public `nginx` add-on source package as the simplest representative add-on in the catalog.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-addons
bash ./scripts/validate-addon-package.sh . --kind addon --name nginx</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">ADDONS</div>
  <h3><a href="./live-matrix-ubuntu24/">Live Matrix Ubuntu24</a></h3>
  <p>Run the full live matrix of public add-ons and stacks inside a fresh Ubuntu 24 VM through the repository's existing harness.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-addons
PRODUCTIVE_K3S_CORE_REPO_DIR=../productive-k3s-core make -C ./tests test-live-matrix-ubuntu24</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">ADDONS</div>
  <h3><a href="./package-layout-basic/">Package Layout Basic</a></h3>
  <p>Validate the full `productive-k3s-addons` source-tree contract before discussing individual add-ons or stacks.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-addons
bash ./scripts/validate-addon-package.sh .</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">ADDONS</div>
  <h3><a href="./stack-contract-base-with-core/">Stack Contract Base With Core</a></h3>
  <p>Validate the `base` stack source against the current `productive-k3s-core` stack contract.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-addons
STACK=base PRODUCTIVE_K3S_CORE_REPO_DIR=../productive-k3s-core make -C ./tests test-contract</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">ADDONS</div>
  <h3><a href="./stack-validate-base-definition/">Stack Validate Base Definition</a></h3>
  <p>Validate the `base` stack definition and inspect its declared add-on composition.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>bash ./scripts/validate-addon-package.sh . --kind stack --name base
awk /\^metadata:/\{in_meta=1\;next\}\ in_meta\ \&amp;\&amp;\ /\^\ \ name:/\{print\ \"stack=\"\ \$2\}\ /\^spec:/\{in_spec=1\;next\}\ in_spec\ \&amp;\&amp;\ /\^\ \ addons:/\{in_addons=1\;next\}\ in_addons\ \&amp;\&amp;\ /\^\ \ \ \ -\ /\{sub\(/\^\ \ \ \ -\ /\,\"\"\,\$0\)\;\ print\ \"addon=\"\ \$0\;\ next\}\ in_addons\ \&amp;\&amp;\ \!/\^\ \ \ \ -\ /\{exit\} ./stacks/base/stack.yaml</code></pre></div>
</article>
