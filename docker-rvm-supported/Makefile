.PHONY: all push-release build build-release push-tag push-latest update shell

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

update:
	docker run -u rvm -v $(shell pwd):/home/rvm/app \
		--rm --name rvm-support-updater -it \
		kingdonb/docker-rvm-support:latest-oci8 \
		bash --login -c 'LD_LIBRARY_PATH=/opt/oracle/instantclient_19_8 rvm 2.7.2 do bundle update'

shell:
	docker run -u rvm -v $(shell pwd):/home/rvm/app \
		--rm --name rvm-support-updater -it \
		kingdonb/rvm-supported:latest \
		bash --login
