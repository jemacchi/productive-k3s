<!-- generated: playbooks-export-mkdocs -->
# Cli Playbooks

Scenarios: 15

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./addon-list-basic/">Addon List Basic</a></h3>
  <p>Review the catalog-backed addon listing exposed by `pk3s`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash -lc './pk3s addon list'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./bundle-info-local/">Bundle Info Local</a></h3>
  <p>Inspect local sibling bundle resolution for both `core` and `infra` through `pk3s`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash -lc 'PRODUCTIVE_K3S_SOURCE=local ./pk3s bundle core info --json &amp;&amp; printf "\n" &amp;&amp; PRODUCTIVE_K3S_SOURCE=local ./pk3s bundle infra info --json'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./bundle-info-remote/">Bundle Info Remote</a></h3>
  <p>Inspect published remote bundle resolution for both `core` and `infra` through `pk3s`.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash -lc 'PRODUCTIVE_K3S_SOURCE=remote ./pk3s bundle core info --json &amp;&amp; printf "\n" &amp;&amp; PRODUCTIVE_K3S_SOURCE=remote ./pk3s bundle infra info --json'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./bundle-resolution-contract/">Bundle Resolution Contract</a></h3>
  <p>Review the recorded CLI manifest contract that ties the CLI version to one Core bundle and one Infra bundle.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash -lc 'tmp="$(mktemp -d)"; trap '"'"'"'"'"'"'"'"'rm -rf "$tmp"'"'"'"'"'"'"'"'"' EXIT; TEST_ARTIFACTS_DIR="$tmp" bash ./tests/contracts/02-bundle-resolution-contract.sh &amp;&amp; cat "$tmp/bundle-resolution-contract.json"'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./ci-workflow-contract/">CI Workflow Contract</a></h3>
  <p>Review the CI wiring contract for Go tests, CLI contracts, and the GitHub-host remote validator.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash -lc 'tmp="$(mktemp -d)"; trap '"'"'"'"'"'"'"'"'rm -rf "$tmp"'"'"'"'"'"'"'"'"' EXIT; TEST_ARTIFACTS_DIR="$tmp" bash ./tests/contracts/07-ci-workflow-contract.sh &amp;&amp; cat "$tmp/ci-workflow-contract.json"'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./core-command-mapping-review/">Core Command Mapping Review</a></h3>
  <p>Review the expected CLI-to-Core command delegation map.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash -lc 'tmp="$(mktemp -d)"; trap '"'"'"'"'"'"'"'"'rm -rf "$tmp"'"'"'"'"'"'"'"'"' EXIT; TEST_ARTIFACTS_DIR="$tmp" bash ./tests/contracts/03-core-command-mapping-contract.sh &amp;&amp; cat "$tmp/core-command-mapping-contract.json"'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./help-and-version/">Help And Version</a></h3>
  <p>Review the top-level `pk3s` help surface and the current CLI version from a local `productive-k3s-cli` checkout.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash -lc './pk3s help &amp;&amp; printf "\n" &amp;&amp; ./pk3s version'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./infra-command-mapping-review/">Infra Command Mapping Review</a></h3>
  <p>Review the expected CLI-to-Infra and CLI-to-profile command delegation map.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash -lc 'tmp="$(mktemp -d)"; trap '"'"'"'"'"'"'"'"'rm -rf "$tmp"'"'"'"'"'"'"'"'"' EXIT; TEST_ARTIFACTS_DIR="$tmp" bash ./tests/contracts/04-infra-command-mapping-contract.sh &amp;&amp; cat "$tmp/infra-command-mapping-contract.json"'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./live-catalog-multipass/">Live Catalog Multipass</a></h3>
  <p>Run the live catalog-backed `multipass` lifecycle through the CLI validator.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash ./tests/live-cli-catalog-multipass.sh</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./live-multipass-remote/">Live Multipass Remote</a></h3>
  <p>Run the live remote `multipass` lifecycle through the CLI validator.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash ./tests/live-cli-multipass-remote.sh</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./live-profile-export-multipass/">Live Profile Export Multipass</a></h3>
  <p>Export a profile bundle through the CLI and replay it into a live `multipass` cluster.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash ./tests/live-cli-profile-export-multipass.sh</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./live-stack-export-ubuntu24/">Live Stack Export Ubuntu24</a></h3>
  <p>Export a stack bundle through the CLI and replay it in a fresh Ubuntu 24 VM.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash ./tests/live-cli-stack-export-ubuntu24.sh</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./profile-fixture-contract/">Profile Fixture Contract</a></h3>
  <p>Review the profile fixture contract used by CLI command tests.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash -lc 'tmp="$(mktemp -d)"; trap '"'"'"'"'"'"'"'"'rm -rf "$tmp"'"'"'"'"'"'"'"'"' EXIT; TEST_ARTIFACTS_DIR="$tmp" bash ./tests/contracts/05-profile-command-contract.sh &amp;&amp; cat "$tmp/profile-command-contract.json"'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./profile-list-and-show-catalog/">Profile List And Show Catalog</a></h3>
  <p>Review the catalog-backed profile discovery surface and one concrete published profile summary.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash -lc './pk3s profile list &amp;&amp; printf "\n" &amp;&amp; ./pk3s profile show aws-single-node-basic'</code></pre></div>
</article>

<article class="pk3s-playbook-card">
  <div class="pk3s-playbook-card__eyebrow">CLI</div>
  <h3><a href="./unsupported-command-contract/">Unsupported Command Contract</a></h3>
  <p>Show the readable failure contract for an unsupported top-level `pk3s` command.</p>
  <div class="pk3s-playbook-inline-command"><pre><code>cd productive-k3s-cli
bash -lc 'set +e; ./pk3s unsupported-command; code=$?; printf "\n[expected-exit] %s\n" "${code}"; test "${code}" -ne 0'</code></pre></div>
</article>
