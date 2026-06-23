# Repository Boundaries

Public clarity depends on keeping each repository focused.

## `productive-k3s`

Owns ecosystem explanation, public navigation, roadmap, quickstarts, and public-facing site content.

## `productive-k3s-core`

Owns the runtime and base installation engine, supported core addons, lifecycle scripts, and technical validation of the core platform.

## `productive-k3s-infra`

Owns the runtime engine used to execute packaged profiles, plus provisioning logic, OpenTofu and Ansible layers, and reusable infrastructure automation.

## `productive-k3s-profiles`

Owns the public profile/scenario source tree that feeds package generation and engine compatibility testing.

## `productive-k3s-cli`

Owns the user-facing command line experience and should map users onto compatible core and infra bundles.

## `productive-k3s-addons`

Owns optional integrations, experiments, and non-core extension paths.

## `productive-k3s-profiles-pro`

Owns private or commercial profiles that should not be published through the public repositories.

## Rule of thumb

If content explains the ecosystem at a public level, it likely belongs here.

If content documents implementation details, it should usually live in the repository that owns that implementation.
