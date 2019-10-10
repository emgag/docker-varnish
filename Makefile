.PHONY: 5.2 5.1 5.0 4.1

5.2:
	docker build --pull \
		-t emgag/varnish:5.2.1 \
		5.2
	docker push emgag/varnish:5.2.1

5.1:
	docker build --pull \
		-t emgag/varnish:5.1.3 \
		5.1
	docker push emgag/varnish:5.1.3

5.0:
	docker build --pull \
		-t emgag/varnish:5.0.0 \
		5.0
	docker push emgag/varnish:5.0.0

4.1:
	docker build --pull \
		-t emgag/varnish:4.1.11 \
		4.1
	docker push emgag/varnish:4.1.11


