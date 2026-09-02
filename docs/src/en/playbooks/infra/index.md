<!-- generated: playbooks-export-mkdocs -->
# Infra Playbooks

Scenarios: 27

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./apply-dry-run-profile-source-multipass/">Apply Dry Run Profile Source Multipass</a></h3>
  <p>Show the local `multipass` apply path in dry-run mode from the source-oriented Infra workflow.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh apply --dry-run --profile ../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./apply-dry-run-profile-source-onprem-basic/">Apply Dry Run Profile Source Onprem Basic</a></h3>
  <p>Preview the source-based `onprem-basic` apply path in dry-run mode.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh apply --profile ../productive-k3s-profiles/profiles/edge/on-prem/basic.env --dry-run</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./artifact-review-exported-multipass-k3sup/">Artifact Review Exported Multipass K3sup</a></h3>
  <p>Export a source-based `multipass` installer bundle with `PRODUCTIVE_K3S_ENGINE=k3sup` and inspect the resulting artifact layout plus embedded `profile.env`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
set -euo pipefail;
rm -rf "/tmp/infra-export";
PRODUCTIVE_K3S_PROFILES_REPO_DIR="../productive-k3s-profiles" PRODUCTIVE_K3S_ENGINE=k3sup bash ./productive-k3s-infra.sh export --profile "../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env" --output "/tmp/infra-export" &gt;/dev/null;
find "/tmp/infra-export" -maxdepth 2 -type f | sort;
printf '\n';
printf '%s\n' '--- profile.tgz entries ---';
tar -tzf "/tmp/infra-export/profile.tgz" | sort;
printf '\n';
printf '%s\n' '--- embedded profile.env ---';
tar -xOf "/tmp/infra-export/profile.tgz" ./profile.env</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./bundle-info-and-bom/">Bundle Info And Bom</a></h3>
  <p>Inspect the Infra CLI/runtime metadata and bill of materials from a local `productive-k3s-infra` checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
bash -lc './productive-k3s-infra.sh bundle info --json &amp;&amp; printf "\n" &amp;&amp; ./productive-k3s-infra.sh bom --json'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./cluster-up-source-multipass/">Cluster Up Source Multipass</a></h3>
  <p>Run the source-based `multipass` cluster bootstrap phase from the sibling `productive-k3s-profiles` checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles/scenarios/local/multipass
make cluster-up</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./destroy-profile-packaged-aws-single-node/">Destroy Profile Packaged AWS Single Node</a></h3>
  <p>Destroy the package-first `aws-single-node` runtime through the public Infra profile lifecycle.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
bash ./productive-k3s-infra.sh profile destroy \
  --tgz "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ" \
  --env-file "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_ENV_FILE"</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./destroy-profile-packaged-onprem-basic-rejected/">Destroy Profile Packaged Onprem Basic Rejected</a></h3>
  <p>Show the explicit public guardrail that packaged `onprem-basic` does not support `destroy`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
./productive-k3s-infra.sh profile destroy --tgz /abs/path/to/on-prem-basic-profile.tgz</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./doctor-basic/">Doctor Basic</a></h3>
  <p>Run the shortest local operator-facing environment sanity check for `productive-k3s-infra`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles bash ./productive-k3s-infra.sh doctor</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./doctor-without-profiles-warning/">Doctor Without Profiles Warning</a></h3>
  <p>Run the explicit warning path for `productive-k3s-infra doctor` without wiring the sibling `productive-k3s-profiles` checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
env -u PRODUCTIVE_K3S_PROFILES_REPO_DIR bash ./productive-k3s-infra.sh doctor</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./down-source-multipass/">Down Source Multipass</a></h3>
  <p>Destroy the source-based `multipass` scenario VMs through the sibling `productive-k3s-profiles` checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles/scenarios/local/multipass
make down</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./export-profile-packaged-multipass/">Export Profile Packaged Multipass</a></h3>
  <p>Export a packaged `multipass` `profile.tgz` into a self-contained installer bundle.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
./productive-k3s-infra.sh profile export \
  --tgz /abs/path/to/multipass-profile.tgz \
  --output /tmp/multipass-installer</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./export-profile-source-multipass/">Export Profile Source Multipass</a></h3>
  <p>Export the source `multipass` profile into a self-contained installer bundle.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh export \
    --profile ../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env \
    --output /tmp/infra-source-export</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./export-profile-source-multipass-k3sup/">Export Profile Source Multipass K3sup</a></h3>
  <p>Export the source-based `multipass` profile into a self-contained installer bundle while forcing `PRODUCTIVE_K3S_ENGINE=k3sup`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
PRODUCTIVE_K3S_ENGINE=k3sup \
  bash ./productive-k3s-infra.sh export --profile ../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env --output /tmp/infra-k3sup-export</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./exported-installer-replay-multipass/">Exported Installer Replay Multipass</a></h3>
  <p>Run the strongest current end-to-end proof for the Infra exported installer contract on the `multipass` profile.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./tests/test-profile-export-artifact.sh</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./list-profiles-source/">List Profiles Source</a></h3>
  <p>List the curated source profiles currently visible to Infra from the sibling `productive-k3s-profiles` checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh list-profiles</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./plan-profile-packaged-aws-single-node/">Plan Profile Packaged AWS Single Node</a></h3>
  <p>Preview the package-first OpenTofu plan for an `aws-single-node` `profile.tgz`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
bash ./productive-k3s-infra.sh profile plan \
  --tgz "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ" \
  --env-file "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_ENV_FILE"</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./plan-profile-packaged-multipass/">Plan Profile Packaged Multipass</a></h3>
  <p>Preview the package-first OpenTofu plan for a packaged `multipass` `profile.tgz`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
./productive-k3s-infra.sh profile plan --tgz /abs/path/to/multipass-profile.tgz</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./plan-profile-source-multipass/">Plan Profile Source Multipass</a></h3>
  <p>Preview the local `multipass` infrastructure plan from the source-oriented Infra workflow.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh plan --profile ../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./plan-profile-source-multipass-k3sup/">Plan Profile Source Multipass K3sup</a></h3>
  <p>Preview the source-based `multipass` plan while forcing `PRODUCTIVE_K3S_ENGINE=k3sup`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
PRODUCTIVE_K3S_ENGINE=k3sup \
  bash ./productive-k3s-infra.sh plan --profile ../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./plan-profile-source-onprem-basic/">Plan Profile Source Onprem Basic</a></h3>
  <p>Preview the source-based `onprem-basic` plan through the profile-driven Infra CLI.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh plan --profile ../productive-k3s-profiles/profiles/edge/on-prem/basic.env</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./preflight-source-onprem-basic/">Preflight Source Onprem Basic</a></h3>
  <p>Run the source-based `onprem-basic` preflight path through the profile-driven Infra CLI.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles/scenarios/edge/onprem-basic
make preflight \
  ONPREM_ENV_FILE=/abs/path/to/onprem.env</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./status-profile-packaged-multipass/">Status Profile Packaged Multipass</a></h3>
  <p>Show the packaged runtime status for a `multipass` `profile.tgz` after a prior package-first plan or install.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
bash ./productive-k3s-infra.sh profile status --tgz "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ"</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./status-source-multipass/">Status Source Multipass</a></h3>
  <p>Re-render and print the source-based `multipass` generated cluster metadata.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-profiles/scenarios/local/multipass
make status</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./validate-profile-packaged-aws-single-node/">Validate Profile Packaged AWS Single Node</a></h3>
  <p>Validate a packaged `aws-single-node` `profile.tgz` through the public Infra runtime surface.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
bash ./productive-k3s-infra.sh profile validate --tgz "$PRODUCTIVE_K3S_INFRA_PLAYBOOK_PROFILE_TGZ"</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./validate-profile-packaged-multipass/">Validate Profile Packaged Multipass</a></h3>
  <p>Validate a packaged `multipass` `profile.tgz` through the public Infra runtime surface.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
./productive-k3s-infra.sh profile validate --tgz /abs/path/to/multipass-profile.tgz</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./validate-profile-source-multipass/">Validate Profile Source Multipass</a></h3>
  <p>Validate the public local `multipass` source profile contract from the sibling `productive-k3s-profiles` checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh validate-profile --profile ../productive-k3s-profiles/profiles/local/multipass/1-server-2-agents.env</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">INFRA</div>
  <h3><a href="./validate-profile-source-onprem-basic/">Validate Profile Source Onprem Basic</a></h3>
  <p>Validate the public `onprem-basic` source profile contract from the sibling `productive-k3s-profiles` checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-infra
PRODUCTIVE_K3S_PROFILES_REPO_DIR=../productive-k3s-profiles \
  bash ./productive-k3s-infra.sh validate-profile --profile ../productive-k3s-profiles/profiles/edge/on-prem/basic.env</code></pre></div>
</article>
