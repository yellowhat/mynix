.DEFAULT_GOAL := help
SHELL          = /usr/bin/env bash -o pipefail
.SHELLFLAGS    = -ec

.PHONY: env
env: ## Start interactive nix container
	podman run \
		--interactive \
		--tty \
		--rm \
		--volume "${PWD}:/data:z" \
		--workdir /data \
		--entrypoint bash \
		docker.io/nixos/nix:latest -c "echo 'experimental-features = nix-command flakes' | tee -a /etc/nix/nix.conf && bash"

.PHONY: help
help: ## Makefile Help Page
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[\/\%a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-21s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST) 2>/dev/null
