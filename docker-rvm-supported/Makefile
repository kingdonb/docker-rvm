.PHONY: all push-release build build-release push-tag push-latest

GIT_SHA_TAG := $(shell git rev-parse --short=8 HEAD)

all: build build-release push-latest push-tag

push-release: push-tag push-latest

build:
	docker image build --squash -f Dockerfile.oci8 -t kingdonb/rvm-supported:$(GIT_SHA_TAG) .

build-release:
	docker tag kingdonb/rvm-supported:$(GIT_SHA_TAG) kingdonb/rvm-supported:latest

push-tag:
	docker push kingdonb/rvm-supported:$(GIT_SHA_TAG)

push-latest: build-release
	docker push kingdonb/rvm-supported:latest
