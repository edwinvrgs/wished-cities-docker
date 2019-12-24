include .env

.PHONY: up down stop prune ps shell-api shell-app clone

default: clone up prepare

up:
	@echo "Starting up containers for for $(PROJECT_NAME)..."
	docker-compose pull
	docker-compose -p $(PROJECT_NAME) run --rm start_dependencies
	docker-compose -p $(PROJECT_NAME) up -d --remove-orphans
	@echo "Sleeping"
	sleep 5

down: stop

stop:
	@echo "Stopping containers for $(PROJECT_NAME)..."
	@docker-compose -p $(PROJECT_NAME) stop

prune:
	@echo "Removing containers for $(PROJECT_NAME)..."
	@docker-compose -p $(PROJECT_NAME) down -v

ps:
	@docker ps --filter name='$(PROJECT_NAME)*'

shell-api:
	docker exec -ti $(shell docker ps --filter name='$(PROJECT_NAME)_api_1' --format "{{ .ID }}") /bin/bash

shell-app:
	docker exec -ti $(shell docker ps --filter name='$(PROJECT_NAME)_app_1' --format "{{ .ID }}") /bin/bash

clone:
	git clone $(FRONT_GIT_URL) --recursive || true
	git clone $(BACK_GIT_URL) --recursive || true

pull:
	cd $(FRONT_PROJECT_NAME); git pull; cd ..
	cd $(BACK_PROJECT_NAME); git pull; cd ..

rm:
	docker-compose -p $(PROJECT_NAME) rm --force app api

build:
	docker-compose -p $(PROJECT_NAME) build --parallel app api

prepare:
	docker-compose -p $(PROJECT_NAME) run api npm run db:prepare

deploy: pull stop rm build up

