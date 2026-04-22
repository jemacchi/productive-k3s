.PHONY: bootstrap dry-run backup validate validate-strict test-smoke test-core

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
	./tests/test-in-vm.sh --profile core
