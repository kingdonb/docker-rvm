.PHONY: docker-build-push

DATE := $(shell date +%Y%m%d)

docker-build-push:
	docker buildx build --tag kingdonb/docker-rvm:${DATE} --tag kingdonb/docker-rvm:latest --push --platform linux/amd64,linux/arm64 .
