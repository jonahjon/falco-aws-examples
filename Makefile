FRONTEND_IMG = redis-timestamp
TAG = latest
REGISTRY_ID ?= 164382793440
DOCKER_PUSH_REPOSITORY=dkr.ecr.us-west-2.amazonaws.com

.PHONY: all
all: create-ecr build push-ecr up

create-ecr:
	aws ecr create-repository --repository-name ${FRONTEND_IMG} || true

build:
	docker --context default build -t $(REGISTRY_ID).$(DOCKER_PUSH_REPOSITORY)/$(FRONTEND_IMG):$(TAG) ./app

push-ecr:
	#aws ecr get-login-password --region us-west-2 | docker login -u AWS --password-stdin $(REGISTRY_ID).$(DOCKER_PUSH_REPOSITORY)
	docker --context default push $(REGISTRY_ID).$(DOCKER_PUSH_REPOSITORY)/$(FRONTEND_IMG):$(TAG)

up:
	docker context use demo
	cd app && docker compose up