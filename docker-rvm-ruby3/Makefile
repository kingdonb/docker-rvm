.PHONY: all push-release build build-release push-tag push-latest update shell

GIT_SHA_TAG := $(shell git rev-parse --short=8 HEAD)

all: build build-release push-latest push-tag

push-release: push-tag push-latest

build:
	docker image build --push --squash -t kingdonb/rvm-ruby3:$(GIT_SHA_TAG) .

build-release:
	docker pull kingdonb/rvm-ruby3:$(GIT_SHA_TAG)
	docker tag kingdonb/rvm-ruby3:$(GIT_SHA_TAG) kingdonb/rvm-ruby3:latest

push-tag:
	docker push kingdonb/rvm-ruby3:$(GIT_SHA_TAG)

push-latest: build-release
	docker push kingdonb/rvm-ruby3:latest

update:
	docker run -u rvm -v $(shell pwd):/home/rvm/app \
		--rm --name rvm-support-updater -it \
		kingdonb/docker-rvm-support:latest-ruby3 \
		bash --login -c 'rvm 3.1.3 do bundle update'

shell:
	docker run -u rvm -v $(shell pwd):/home/rvm/app \
		--rm --name rvm-support-updater -it \
		kingdonb/rvm-ruby3:latest \
		bash --login
