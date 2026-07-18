# Ecosystem

This section explains the conceptual model behind Productive K3S before you dive into the technical detail of each repository.

Use it when you want to understand:

- how the public pieces fit together;
- which components are independent and which build on top of others;
- where the recommended CLI experience fits in;
- how curated deployment solutions and curated cluster extensions live in different layers.

## Conceptual model

- `Productive K3S Core` is the technical base. You can use it by itself when you want the simplest direct path into a real Kubernetes base.
- `Productive K3S Infra` builds on `Core` and handles deployment orchestration across platforms.
- `Productive K3S Profiles` defines curated deployment solutions that `Infra` can interpret and execute.
- `Productive K3S Addons` defines curated cluster extensions that `Core` can install.
- `Productive K3S CLI` is the simplest and recommended unified interface, but it is not mandatory.

## Independence and dependency

- `Core` can be used directly.
- `Infra` depends on `Core`, but not on `CLI`.
- `CLI` is recommended for simplicity, not required for correctness.
- `Profiles` and `Addons` are different curated layers: deployment solutions vs cluster extensions.

## Pages

- [Repository map](repositories.md)
- [Repository boundaries](boundaries.md)
