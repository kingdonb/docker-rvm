.PHONY: all push-release build build-release tag-latest push-tag push-latest

GIT_SHA_TAG := $(shell git rev-parse --short=8 HEAD)

all: build build-release tag-latest push-latest push-tag

push-release: push-tag push-latest

build:
	docker build --no-cache --progress=plain -f Dockerfile.oci8 -t kingdonb/rvm-supported:latest .

build-release:
	docker build -f Dockerfile.oci8 -t kingdonb/rvm-supported:$(GIT_SHA_TAG) .

tag-latest: build
	docker tag kingdonb/rvm-supported:$(GIT_SHA_TAG) kingdonb/rvm-supported:latest

push-tag: build
	docker push kingdonb/rvm-supported:$(GIT_SHA_TAG)

push-latest: tag-latest
	docker push kingdonb/rvm-supported:latest
