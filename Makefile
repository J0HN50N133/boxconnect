# Use Podman as container runtime
CONTAINER_CMD := podman

check-container:
	@if ! command -v podman >/dev/null 2>&1; then \
		echo "Error: podman not found. Please install podman:"; \
		echo "  - To install podman: https://podman.io/getting-started/installation"; \
		exit 1; \
	fi

build: check-container
	-$(CONTAINER_CMD) image rm openconnect
	$(CONTAINER_CMD) build -f Dockerfile -t openconnect

vpn: check-container
	$(CONTAINER_CMD) run --rm -it \
		--network slirp4netns \
		-e SERVER=$(SERVER) \
		-e USERNAME=$(USERNAME) \
		-e PASSWORD=$(PASSWORD) \
		-v $(HOME)/.ssh:/root/.ssh \
		--device /dev/net/tun \
		--cap-add=NET_ADMIN \
		openconnect
