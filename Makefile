.PHONY: all 6.1 6.0 5.2 5.1 5.0 4.1

all: 6.1 6.0 4.1

6.1:
	docker build --pull \
		-t emgag/varnish:testing \
		-t emgag/varnish:6.1 \
		-t emgag/varnish:6.1.1 \
		6.1
	docker push emgag/varnish:testing
	docker push emgag/varnish:6.1
	docker push emgag/varnish:6.1.0


6.0:
	docker build --pull \
		-t emgag/varnish:latest \
		-t emgag/varnish:6 \
		-t emgag/varnish:6.0 \
		-t emgag/varnish:6.0.2 \
		6.0
	docker push emgag/varnish:latest
	docker push emgag/varnish:6
	docker push emgag/varnish:6.0
	docker push emgag/varnish:6.0.2

5.2:
	docker build --pull \
		-t emgag/varnish:5 \
		-t emgag/varnish:5.2 \
		-t emgag/varnish:5.2.1 \
		5.2
	docker push emgag/varnish:5
	docker push emgag/varnish:5.2
	docker push emgag/varnish:5.2.1

5.1:
	docker build --pull \
		-t emgag/varnish:5.1 \
		-t emgag/varnish:5.1.3 \
		5.1
	docker push emgag/varnish:5.1
	docker push emgag/varnish:5.1.3

5.0:
	docker build --pull \
		-t emgag/varnish:5.0 \
		-t emgag/varnish:5.0.0 \
		5.0
	docker push emgag/varnish:5.0
	docker push emgag/varnish:5.0.0

4.1:
	docker build --pull \
		-t emgag/varnish:4 \
		-t emgag/varnish:4.1 \
		-t emgag/varnish:4.1.10 \
		4.1
	docker push emgag/varnish:4
	docker push emgag/varnish:4.1 
	docker push emgag/varnish:4.1.10


