# Repository Boundaries

Public clarity depends on keeping each repository focused.

## `productive-k3s`

Owns ecosystem explanation, public navigation, roadmap, quickstarts, and public-facing site content.

## `productive-k3s-core`

Owns the base Kubernetes installation contract, cluster assembly modes, and addon or stack package installation.

## `productive-k3s-infra`

Owns the deployment and orchestration layer that interprets curated solution paths on top of Core.

## `productive-k3s-profiles`

Owns the curated public deployment solutions and the source tree that defines them.

## `productive-k3s-cli`

Owns the simplest and recommended user-facing command interface across the ecosystem.

## `productive-k3s-addons`

Owns curated cluster extensions that Core can install as addons or grouped stacks.

## Rule of thumb

If content explains the ecosystem at a public level, it likely belongs here.

If content documents implementation details, it should usually live in the repository that owns that implementation.
