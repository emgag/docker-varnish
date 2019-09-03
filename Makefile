.PHONY: all 6.2 6.0

IMAGE_60_VERSION := 6.0.4
IMAGE_62_VERSION := 6.2.1

all: 6.2 6.0

6.2:
	docker build --pull \
		-t emgag/varnish:${IMAGE_62_VERSION} \
		6.2
	docker push emgag/varnish:${IMAGE_62_VERSION}

6.0:
	docker build --pull \
		-t emgag/varnish:${IMAGE_60_VERSION} \
		6.0
	docker push emgag/varnish:${IMAGE_60_VERSION}
