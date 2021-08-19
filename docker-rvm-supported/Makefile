.PHONY: all push-release build build-release push-tag push-latest update shell

GIT_SHA_TAG := $(shell git rev-parse --short=8 HEAD)

all: build build-release push-latest push-tag

push-release: push-tag push-latest

build:
	docker image build --squash -f Dockerfile -t kingdonb/rvm-supported:$(GIT_SHA_TAG) .

build-release:
	docker tag kingdonb/rvm-supported:$(GIT_SHA_TAG) kingdonb/rvm-supported:latest

push-tag:
	docker push kingdonb/rvm-supported:$(GIT_SHA_TAG)

push-latest: build-release
	docker push kingdonb/rvm-supported:latest

update:
	docker run -u rvm -v $(shell pwd):/home/rvm/app \
		--rm --name rvm-support-updater -it \
		kingdonb/docker-rvm-support:latest \
		bash --login -c 'rvm 2.7.4 do bundle update'

shell:
	docker run -u rvm -v $(shell pwd):/home/rvm/app \
		--rm --name rvm-support-updater -it \
		kingdonb/rvm-supported:latest \
		bash --login
