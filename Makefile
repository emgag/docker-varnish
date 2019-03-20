.PHONY: all 6.2 6.0

all: 6.2 6.0

6.2:
	docker build --pull \
		-t emgag/varnish:testing \
		-t emgag/varnish:6.2.0 \
		6.2
	docker push emgag/varnish:testing
	docker push emgag/varnish:6.2.0

6.0:
	docker build --pull \
		-t emgag/varnish:6.0.3-1 \
		6.0
	docker push emgag/varnish:6.0.3-1

