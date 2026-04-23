# Debian 12 Candidate Platform

This document defines the initial path for validating Debian 12 as a candidate platform.

Ubuntu remains the supported and validated baseline. Debian 12 is not promoted to fully supported until the required VM profiles produce successful artifacts.

## Current Status

Status: candidate

Target release:

- Debian 12 `bookworm`

Current validation evidence:

- `smoke`: passed with artifact `status: "success"`
- `core`: passed with artifact `status: "success"`
- `full`: passed with artifact `status: "success"`
- `full-rollback`: pending
- `full-clean`: pending

Why Debian 12 first:

- it is close to the Ubuntu/Debian package and service model already used by this repository
- it uses `apt-get` and `dpkg`
- it normally uses `systemd`
- package names for key host dependencies are expected to be close to Ubuntu

## Scope

The first goal is to validate Debian 12 as a VM target, not as a Windows/macOS/native host target.

The target model is:

- host: any machine capable of running Multipass
- VM guest: Debian 12 cloud image
- scripts: executed inside the Debian 12 VM

## What Changed For Candidate Testing

The VM harness supports:

```bash
./tests/test-in-vm.sh --platform debian12
```

When `--platform debian12` is used, the harness defaults to:

- image: `https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2`
- remote user: `debian`
- remote directory: `/home/debian/productive-k3s`

These values can be overridden:

```bash
./tests/test-in-vm.sh --platform debian12 --image <image-or-url> --remote-user <user> --remote-dir <path>
```

The bootstrap also detects the host OS through `/etc/os-release`.

Current behavior:

- Ubuntu: supported baseline
- Debian 12: candidate
- anything else: unsupported

## Validation Sequence

Run the candidate validation in this order.

### 1. Smoke

```bash
./tests/test-in-vm.sh --platform debian12 --image https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2 --profile smoke
```

Expected:

- VM launches
- repository transfers
- bootstrap dry-run starts
- artifact records `status: "success"`

### 2. Core

```bash
./tests/test-in-vm.sh --platform debian12 --image https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2 --profile core
```

Expected:

- `k3s` installs
- `helm` installs
- non-strict validation completes
- artifact records `status: "success"`

### 3. Full

```bash
./tests/test-in-vm.sh --platform debian12 --image https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2 --profile full
```

Expected:

- full stack installs
- strict validation converges
- artifact records `status: "success"`

### 4. Full Rollback

```bash
./tests/test-in-vm.sh --platform debian12 --image https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2 --profile full-rollback
```

Expected:

- full stack installs
- rollback plan is generated
- rollback apply completes
- target namespaces and resources are removed
- artifact records `status: "success"`

### 5. Full Clean

```bash
./tests/test-in-vm.sh --platform debian12 --image https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2 --profile full-clean
```

Expected:

- full stack installs
- destructive cleanup completes
- `k3s` is no longer active
- artifact records `status: "success"`

## Artifact Review

Check recent Debian candidate artifacts:

```bash
ls -1t test-artifacts/*debian12*.json | head
jq '{status, profile, platform, image, remote_user, remote_dir, vm_name}' test-artifacts/*debian12*.json
```

Pass criteria:

- every required profile must have `status: "success"`
- every required profile must have `platform: "debian12"`

Do not use `*-bootstrap-manifest.json` as the primary pass/fail signal. Use the `test-in-vm-*.json` test result artifact.

## Known Risk Areas

Debian 12 is expected to be close to Ubuntu, but the following areas must be verified empirically:

- Multipass behavior with Debian cloud images
- default cloud user and SSH access
- `multipass transfer` into the Debian VM
- `open-iscsi` package and `iscsid` service behavior
- NFS package and service behavior
- Longhorn dependencies
- Rancher/Fleet startup timing
- cleanup of CNI interfaces and k3s runtime state

## Promotion Criteria

Debian 12 should remain candidate until the following profiles pass and artifacts are retained:

1. `smoke`
2. `core`
3. `full`
4. `full-rollback`
5. `full-clean`

After those pass, update this document and the main README to move Debian 12 from candidate to supported.

## Fallbacks During Validation

If the default Debian image does not work with Multipass on a given host, try an explicit image override:

```bash
./tests/test-in-vm.sh --platform debian12 --image <debian-cloud-image-url> --profile smoke
```

If the default user is not `debian`, override it:

```bash
./tests/test-in-vm.sh --platform debian12 --remote-user <user> --profile smoke
```

If the remote home directory differs:

```bash
./tests/test-in-vm.sh --platform debian12 --remote-dir /tmp/productive-k3s --profile smoke
```

Using `/tmp/productive-k3s` is acceptable for test validation if the cloud image user/home layout is different from the expected default.
