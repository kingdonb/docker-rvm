.PHONY: build tag-latest push-tag push-latest push support check
.PHONY: legacy build-legacy push-legacy unsupported local-only

ISO_DATE_TAG := $(shell date +%Y%m%d)

all: build push support

legacy: build-legacy push-legacy unsupported

local-only: tag-latest support

build-legacy:
	docker build --no-cache -t kingdonb/docker-rvm:$(ISO_DATE_TAG)-legacy -f Dockerfile.legacy .

push-legacy: build-legacy
	docker push kingdonb/docker-rvm:$(ISO_DATE_TAG)-legacy

build:
	docker build --no-cache -t kingdonb/docker-rvm:$(ISO_DATE_TAG) .

check:
	docker pull yebyen/docker-rvm:test
	docker build -f docker-rvm-test/Dockerfile.check -t yebyen/docker-rvm:check .

tag-latest: build
	docker tag kingdonb/docker-rvm:$(ISO_DATE_TAG) kingdonb/docker-rvm:latest

push-tag: build
	docker push kingdonb/docker-rvm:$(ISO_DATE_TAG)

push-latest: tag-latest
	docker push kingdonb/docker-rvm:latest

push: push-tag push-latest

support:
	$(MAKE) -C docker-rvm-support supported
	$(MAKE) -C docker-rvm-supported all
	$(MAKE) -C docker-rvm-support build-push-ruby3
	$(MAKE) -C docker-rvm-ruby3

unsupported:
	$(MAKE) -C docker-rvm-support unsupported
