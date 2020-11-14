CONTAINER := sogo

default: all

all: build push

push:
	docker push petewilcox/${CONTAINER}:0.1

build:
	docker build --force-rm --compress --no-cache --tag petewilcox/${CONTAINER}:0.1 .

.PHONY: all build push default
