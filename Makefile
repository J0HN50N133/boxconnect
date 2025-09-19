# Detect available container runtime
CONTAINER_CMD := $(shell which podman || which docker || echo "none")

check-container:
	@if [ "$(CONTAINER_CMD)" = "none" ]; then \
		echo "Error: Neither podman nor docker found. Please install one of them:"; \
		echo "  - To install podman: https://podman.io/getting-started/installation"; \
		echo "  - To install docker: https://docs.docker.com/get-docker/"; \
		exit 1; \
	fi

build: check-container
	-$(CONTAINER_CMD) image rm openconnect
	$(CONTAINER_CMD) build -f Dockerfile -t openconnect

vpn: check-container
	$(CONTAINER_CMD) run --rm -it \
		-e SERVER=$(SERVER) \
		-e USERNAME=$(USERNAME) \
		-e PASSWORD=$(PASSWORD) \
		-v $(HOME)/.ssh:/root/.ssh \
		--cap-add=NET_ADMIN \
		--device /dev/net/tun \
		openconnect
