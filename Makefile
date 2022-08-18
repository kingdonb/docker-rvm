.PHONY: build tag-latest push-tag push-latest push support check
.PHONY: legacy build-legacy push-legacy unsupported local-only

ISO_DATE_TAG := $(shell date +%Y%m%d)

all: build push support ruby3

legacy: build-legacy push-legacy unsupported

local-only: tag-latest support

build-legacy:
	docker build --no-cache -t kingdonb/docker-rvm:$(ISO_DATE_TAG)-legacy -f Dockerfile.legacy .

push-legacy: build-legacy
	docker push kingdonb/docker-rvm:$(ISO_DATE_TAG)-legacy

build:
	docker build --push --no-cache -t kingdonb/docker-rvm:$(ISO_DATE_TAG) .
	docker pull kingdonb/docker-rvm:$(ISO_DATE_TAG)

check:
	docker pull yebyen/docker-rvm:test
	docker build -f docker-rvm-test/Dockerfile.check -t yebyen/docker-rvm:check .

tag-latest: build
	docker pull kingdonb/docker-rvm:$(ISO_DATE_TAG)
	docker tag kingdonb/docker-rvm:$(ISO_DATE_TAG) kingdonb/docker-rvm:latest

push-tag: build
	docker push kingdonb/docker-rvm:$(ISO_DATE_TAG)

push-latest: tag-latest
	docker push kingdonb/docker-rvm:latest

NEXT_TAG?=$(ISO_DATE_TAG)
VERSION:=$(shell grep 'VERSION' .latest-release | awk '{ print $$3 }' | tr -d "'")
version-set:
	@next="$(NEXT_TAG)" && \
	current="$(VERSION)" && \
	/usr/bin/sed -i'' "s/$$current/$$next/g" .latest-release && \
	/usr/bin/sed -i'' "s/:$$current/:$$next/g" docker-rvm-support/Dockerfile && \
	/usr/bin/sed -i'' "s/:$$current/:$$next/g" docker-rvm-support/Dockerfile.oci8 && \
	/usr/bin/sed -i'' "s/:$$current/:$$next/g" docker-rvm-support/Dockerfile.ruby3 && \
	/usr/bin/sed -i'' "s/:$$current-ruby3/:$$next-ruby3/g" docker-rvm-ruby3/Dockerfile && \
	/usr/bin/sed -i'' "s/:$$current/:$$next/g" docker-rvm-supported/Dockerfile && \
	echo "Version $$next set in .latest-release and Dockerfiles"

push: push-tag push-latest

support:
	$(MAKE) -C docker-rvm-support supported
	$(MAKE) -C docker-rvm-supported all

ruby3:
	$(MAKE) -C docker-rvm-support build-push-ruby3
	$(MAKE) -C docker-rvm-ruby3

unsupported:
	$(MAKE) -C docker-rvm-support unsupported
