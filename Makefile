APT_PROXY ?=
DOCKER ?= docker

all:

build:
	$(DOCKER) build -t ypcs/prometheus:latest --build-arg APT_PROXY=$(APT_PROXY) .

run: build
	$(DOCKER) run -d -p 127.0.0.1:9090:9090 ypcs/prometheus:latest
