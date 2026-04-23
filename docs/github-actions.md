# GitHub Actions And Release Automation

This document defines the repository automation model for releases and hosted CI validation.

## Scope

There are two separate workflows:

1. release packaging and publication
2. GitHub-hosted validation on Ubuntu 24.04

They must remain separate.

Do not mix release publication with validation in a single workflow.

## Why Hosted Validation Is Limited

The GitHub Actions CI path does not use Multipass.

The hosted CI goal is:

- run on a GitHub-hosted `ubuntu-24.04` runner
- validate shell syntax
- run the Docker smoke harness
- run `scripts/bootstrap-k3s-stack.sh --dry-run` directly on the runner host
- collect logs and the generated dry-run manifest

This gives a useful CI signal, but it is intentionally lighter than local Multipass validation.

It does not replace local Multipass-based testing for:

- real VM bootstrap
- rollback validation
- full clean validation
- Debian candidate validation

## Runner Model

Release workflow:

- GitHub-hosted Ubuntu runner

Hosted validation workflow:

- GitHub-hosted `ubuntu-24.04`

Reason:

- this avoids depending on nested virtualization in GitHub-hosted runners
- the workflow remains reproducible and low-maintenance
- the heavier Multipass path stays local, where the repository already has dedicated tooling

## Release Workflow

Trigger:

- push of a version tag such as `v1.2.3`

Guard:

- the tag commit must be reachable from `origin/main`

Outputs:

- `productive-k3s-<tag>.tar.gz`
- `productive-k3s-<tag>.tar.gz.sha256`
- `install-productive-k3s.sh`

The release workflow creates a GitHub Release and uploads those files as release assets.

The installer script is versioned per release and can be used like this:

```bash
curl -fsSL https://github.com/<owner>/<repo>/releases/download/vX.Y.Z/install-productive-k3s.sh | bash
```

Additional bootstrap flags can still be passed:

```bash
curl -fsSL https://github.com/<owner>/<repo>/releases/download/vX.Y.Z/install-productive-k3s.sh | bash -s -- --dry-run
```

## Hosted Validation Workflow

Trigger:

- pull request against `main`
- activity types:
  - `opened`
  - `reopened`
  - `ready_for_review`
- optional manual dispatch

Notes:

- it does not run on every commit pushed to an existing PR
- it does not run on `pull_request.synchronize`
- draft PRs are skipped until they are marked ready for review

The workflow should:

- run on `ubuntu-24.04`
- run shell syntax checks
- run `tests/test-in-docker.sh`
- run `scripts/bootstrap-k3s-stack.sh --dry-run` directly on the runner host
- upload `test-artifacts/` and `runs/` as workflow artifacts
- fail if `test-artifacts/hosted-validation-summary.json` does not end with `status == "success"`

## Local Heavy Validation

The following validations remain local responsibilities:

- `./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile full`
- `./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile full-rollback`
- `./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile full-clean`
- `./tests/test-in-vm.sh --platform debian12 --image https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2 --profile ...`

Those checks are still the source of truth for real installation and teardown behavior.
