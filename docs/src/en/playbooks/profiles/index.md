<!-- generated: playbooks-export-mkdocs -->
# Profiles Playbooks

Scenarios: 13

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="./live-matrix/">Live Matrix</a></h3>
  <p>Run the full live matrix across every discovered public `profiles` scenario.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-live-matrix</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="./live-multipass/">Live Multipass</a></h3>
  <p>Run the live `multipass` scenario validation path from the `productive-k3s-profiles` source checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
SCENARIO=multipass PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-live</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="./live-onprem-basic/">Live Onprem Basic</a></h3>
  <p>Run the live `onprem-basic` remote validation path from the `productive-k3s-profiles` source checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
SCENARIO=onprem-basic PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-live</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="./matrix-development-infra/">Matrix Development Infra</a></h3>
  <p>Run the full non-live `profiles` matrix against the sibling `productive-k3s-infra` checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-matrix</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="./profile-layout-basic/">Profile Layout Basic</a></h3>
  <p>Review the public `profiles/` and `scenarios/` tree from the `productive-k3s-profiles` source checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
find profiles scenarios -maxdepth 3 -type f | sort</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="./validate-contract-aws-single-node/">Validate Contract Aws Single Node</a></h3>
  <p>Run the `aws-single-node` contract validation path from the `productive-k3s-profiles` source checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
SCENARIO=aws-single-node PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-contract</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="./validate-contract-multipass/">Validate Contract Multipass</a></h3>
  <p>Run the `multipass` contract validation path from the `productive-k3s-profiles` source checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
SCENARIO=multipass PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-contract</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="./validate-contract-onprem-basic/">Validate Contract Onprem Basic</a></h3>
  <p>Run the `onprem-basic` contract validation path from the `productive-k3s-profiles` source checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
SCENARIO=onprem-basic PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-contract</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="./validate-contract-onprem-basic-arm/">Validate Contract Onprem Basic Arm</a></h3>
  <p>Run the `onprem-basic-arm` contract validation path from the `productive-k3s-profiles` source checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
SCENARIO=onprem-basic-arm PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-contract</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="./validate-static-aws-single-node/">Validate Static Aws Single Node</a></h3>
  <p>Run the `aws-single-node` static validation path without applying cloud changes.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
SCENARIO=aws-single-node PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-static</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="./validate-static-multipass/">Validate Static Multipass</a></h3>
  <p>Run the `multipass` static validation path from the `productive-k3s-profiles` source checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
SCENARIO=multipass PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-static</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="./validate-static-onprem-basic/">Validate Static Onprem Basic</a></h3>
  <p>Run the `onprem-basic` static validation path from the `productive-k3s-profiles` source checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
SCENARIO=onprem-basic PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-static</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">PROFILES</div>
  <h3><a href="./validate-static-onprem-basic-arm/">Validate Static Onprem Basic Arm</a></h3>
  <p>Run the `onprem-basic-arm` static validation path from the `productive-k3s-profiles` source checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles
SCENARIO=onprem-basic-arm PRODUCTIVE_K3S_INFRA_REPO_DIR=../productive-k3s-infra bash ./scripts/productive-k3s-profiles-dev.sh test-static</code></pre></div>
</article>
