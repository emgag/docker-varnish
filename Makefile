.PHONY: all 6.3 6.2 6.0 builder readme

REPO := emgag/varnish
IMAGE_60_VERSION := 6.0.6
IMAGE_62_VERSION := 6.2.3
IMAGE_63_VERSION := 6.3.2

all: 6.3 6.2 6.0

readme:
	docker run --rm -v ${CURDIR}:/workspace \
		-e DOCKERHUB_USERNAME="${DOCKERHUB_USERNAME}" \
		-e DOCKERHUB_PASSWORD="${DOCKERHUB_PASSWORD}" \
		-e DOCKERHUB_REPOSITORY="${REPO}" \
		-e README_FILEPATH="/workspace/README.md" \
  		peterevans/dockerhub-description@sha256:03be22045dfedb1360665e0f62c27d90a800906476b35a7164b242b5d861f4ef

6.3: readme
	docker build --pull \
		-t ${REPO}:${IMAGE_63_VERSION} \
		6.3
	docker push ${REPO}:${IMAGE_63_VERSION}

6.2: readme
	docker build --pull \
		-t ${REPO}:${IMAGE_62_VERSION} \
		6.2
	docker push ${REPO}:${IMAGE_62_VERSION}

6.0: readme
	docker build --pull \
		-t ${REPO}:${IMAGE_60_VERSION} \
		6.0
	docker push ${REPO}:${IMAGE_60_VERSION}

builder:
	docker build --pull \
		-t ${REPO}:6.3-vmod-builder-xenial \
		builder/6.3-xenial
