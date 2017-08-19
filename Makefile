help:
	@cat Makefile

DOCKER_FILE=Dockerfile
BACKEND=tensorflow
TEST=tests/
PY?=3.5
NAME?=keras

ifndef $(SRC)
	SRC?=$(shell pwd)
endif
ifndef $(DATA)
	DATA?=${HOME}/Data
endif

GPU?=0
ifeq ($(GPU), 0)
	DOCKER=docker
else
	DOCKER=GPU=$(GPU) nvidia-docker
endif

build:
	docker build -t $(NAME) --build-arg python_version=$(PY) -f $(DOCKER_FILE) .

bash: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/data --env KERAS_BACKEND=$(BACKEND) $(NAME) bash

ipython: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/data --env KERAS_BACKEND=$(BACKEND) $(NAME) ipython

notebook: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/data --net=host --env KERAS_BACKEND=$(BACKEND) $(NAME)

test: build
	$(DOCKER) run -it -v $(SRC):/src -v $(DATA):/data --env KERAS_BACKEND=$(BACKEND) $(NAME) py.test $(TEST)