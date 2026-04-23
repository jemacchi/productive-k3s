.PHONY: bootstrap dry-run backup validate validate-strict test-smoke test-core test-core-debian12

bootstrap:
	./scripts/bootstrap-k3s-stack.sh

dry-run:
	./scripts/bootstrap-k3s-stack.sh --dry-run

backup:
	./scripts/backup-k3s-stack.sh

validate:
	./scripts/validate-k3s-stack.sh

validate-strict:
	./scripts/validate-k3s-stack.sh --strict

test-smoke:
	./tests/test-in-docker.sh

test-core:
	./tests/test-in-vm.sh --platform ubuntu --image 24.04 --profile core

test-core-debian12:
	./tests/test-in-vm.sh --platform debian12 --image https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2 --profile core
