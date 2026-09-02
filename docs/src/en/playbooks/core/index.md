<!-- generated: playbooks-export-mkdocs -->
# Core Playbooks

Scenarios: 25

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./addon-install-packaged-public-host/">Addon Install Packaged Public Host</a></h3>
  <p>Install a packaged addon and request a basic public ingress host.</p>
  
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./addon-validate-package/">Addon Validate Package</a></h3>
  <p>Validate an addon package before installation.</p>
  
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./apply-dry-run-server/">Apply Dry Run Server</a></h3>
  <p>Preview the preferred `core` installation path without changing the host.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
bash ./productive-k3s-core.sh apply --dry-run --mode server</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./apply-dry-run-single-node/">Apply Dry Run Single Node</a></h3>
  <p>Preview the legacy all-in-one `single-node` path to understand how it differs from the preferred `server` mode.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
bash ./productive-k3s-core.sh apply --dry-run --mode single-node</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./apply-server/">Apply Server</a></h3>
  <p>Run the preferred core-only installation on a supported host.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
bash ./productive-k3s-core.sh apply --mode server</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./backup-local-cluster/">Backup Local Cluster</a></h3>
  <p>Capture a support-oriented backup snapshot of host and cluster state after bootstrap.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
bash ./productive-k3s-core.sh backup /tmp/pk3s-core-backup-01</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./bundle-info-and-bom/">Bundle Info And BOM</a></h3>
  <p>Inspect what the `core` CLI bundle is, which runtime files it carries, and which component versions it pins.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>bash ./productive-k3s-core.sh bundle info --json
bash ./productive-k3s-core.sh bom --json</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./exported-installer-k3sup-ubuntu24/">Exported Installer K3sup Ubuntu24</a></h3>
  <p>Validate the self-contained exported base installer on Ubuntu 24.04 with `PRODUCTIVE_K3S_ENGINE=k3sup`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
make -C ./tests test-exported-stack-installer-k3sup-ubuntu24</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./exported-installer-rke2-ubuntu24/">Exported Installer RKE2 Ubuntu24</a></h3>
  <p>Validate the self-contained exported base installer on Ubuntu 24.04 with `PRODUCTIVE_K3S_DISTRO=rke2`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
make -C ./tests test-exported-stack-installer-rke2-ubuntu24</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./preflight-basic/">Preflight Basic</a></h3>
  <p>Run the standard host compatibility check from a local `productive-k3s-core` checkout before attempting any installation.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
bash ./productive-k3s-core.sh preflight</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./preflight-strict-json/">Preflight Strict JSON</a></h3>
  <p>Run host preflight in a CI- or automation-friendly mode where warnings also fail the run and output is machine-readable.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
bash ./productive-k3s-core.sh preflight --strict --json-output</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./rke2-core-ubuntu24/">RKE2 Core Ubuntu24</a></h3>
  <p>Run the dedicated Ubuntu 24.04 VM profile that bootstraps `productive-k3s-core` with `PRODUCTIVE_K3S_DISTRO=rke2`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
make -C ./tests test-rke2-core</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./rke2-full-ubuntu24/">RKE2 Full Ubuntu24</a></h3>
  <p>Run the dedicated Ubuntu 24.04 full VM profile for `PRODUCTIVE_K3S_DISTRO=rke2`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
make -C ./tests test-rke2-full</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./stack-base-artifact-review/">Stack Base Artifact Review</a></h3>
  <p>Review a packaged stack artifact and, optionally, an exported installer directory.</p>
  
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./stack-base-backup/">Stack Base Backup</a></h3>
  <p>Capture a backup while enabling stack-aware addon hooks through `PRODUCTIVE_K3S_STACK_NAME=base`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
PRODUCTIVE_K3S_STACK_NAME=base ./productive-k3s-core.sh backup '/tmp/pk3s-base-stack-backup'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./stack-base-cleanup-apply/">Stack Base Cleanup Apply</a></h3>
  <p>Apply the destructive cleanup path for `base`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>bash ./productive-k3s-core.sh stack cleanup base --apply --yes --confirm-clean</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./stack-base-cleanup-plan/">Stack Base Cleanup Plan</a></h3>
  <p>Review the destructive cleanup scope for `base` without applying it.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>bash ./productive-k3s-core.sh stack cleanup base --plan</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./stack-base-longhorn-and-rancher-checks/">Stack Base Longhorn And Rancher Checks</a></h3>
  <p>Run the typical Longhorn and Rancher post-install checks for the `base` stack.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>bash ./utils/inspect-longhorn.sh
bash ./utils/inspect-longhorn-volumes.sh
bash ./utils/inspect-rancher.sh
bash -lc sudo\ k3s\ kubectl\ get\ pods\ -n\ longhorn-system\ -o\ wide
bash -lc sudo\ k3s\ kubectl\ get\ pods\ -n\ cattle-system\ -o\ wide
bash -lc sudo\ k3s\ kubectl\ rollout\ status\ deploy/rancher\ -n\ cattle-system\ --timeout=60s</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./stack-base-registry-checks/">Stack Base Registry Checks</a></h3>
  <p>Validate registry behavior after `base` is installed.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>bash ./productive-k3s-core.sh validate --strict --docker-registry-test
bash -lc curl\ -kI\ https://registry.home.arpa/v2/
bash -lc curl\ -k\ https://registry.home.arpa/v2/_catalog\ \|\ jq
bash ./utils/list-registry-images.sh --json</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./stack-export-base/">Stack Export Base</a></h3>
  <p>Export a packaged stack artifact into a self-contained installer bundle.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
bash ./productive-k3s-core.sh stack export --tgz /tmp/base-stack.tgz --output /tmp/base-installer</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./stack-install-base/">Stack Install Base</a></h3>
  <p>Install the default `base` stack on top of a cluster already created with `apply --mode server`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
bash ./productive-k3s-core.sh stack install base</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./stack-install-exported-base/">Stack Install Exported Base</a></h3>
  <p>Replay a previously exported installer bundle from its extracted directory.</p>
  
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./stack-validate-after-install/">Stack Validate After Install</a></h3>
  <p>Re-run stack-aware validation after `stack install base`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
bash ./productive-k3s-core.sh stack validate base --strict</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./stack-validate-base/">Stack Validate Base</a></h3>
  <p>Validate the explicit `base` stack before or after installation.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
bash ./productive-k3s-core.sh stack validate base --strict</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CORE</div>
  <h3><a href="./validate-local-cluster/">Validate Local Cluster</a></h3>
  <p>Run the standard post-apply validator against the local cluster.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-core
bash ./productive-k3s-core.sh validate --strict</code></pre></div>
</article>
