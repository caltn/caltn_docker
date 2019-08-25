
DOCKER_COMPOSE_BASE := -f ./compose-base.yml \
		-f ./compose-redis.yml \
		-f ./compose-mysql.yml \
		-f ./compose-php.yml \
		-f ./compose-postgres.yml \
		-f ./compose-gitlab.yml \
		-f ./compose-nodejsapp.yml \



DOCKER_COMPOSE_CADDY := -f ./compose-caddy.yml \
		$(DOCKER_COMPOSE_BASE) \
		-f ./compose-gitlab-caddy.yml \
		-f ./compose-nodejsapp-caddy.yml \
		-f ./compose-php-caddy.yml \



DOCKER_COMPOSE_NGINX := -f ./compose-nginx.yml \
		$(DOCKER_COMPOSE_BASE) \
		-f ./compose-gitlab-nginx.yml \
		-f ./compose-nodejsapp-nginx.yml \
		-f ./compose-php-nginx.yml \



DOCKER_COMPOSE_EXPORT_FILE := export-compose.yml



.PHONY: config_nginx
config_nginx:
	docker-compose \
	$(DOCKER_COMPOSE_NGINX) \
	config



.PHONY: config_caddy
config_caddy:
	docker-compose \
	$(DOCKER_COMPOSE_CADDY) \
	config



.PHONY: export_config_nginx
export_config_nginx: 
	@docker-compose \
	$(DOCKER_COMPOSE_NGINX) \
	config > ./$(DOCKER_COMPOSE_EXPORT_FILE)



.PHONY: export_config_caddy
export_config_caddy: 
	@docker-compose \
	$(DOCKER_COMPOSE_CADDY) \
	config > ./$(DOCKER_COMPOSE_EXPORT_FILE)



.PHONY: to_dev
to_dev:
	@echo "===========	to_dev	============="
	cat ./envs/dev.env ./envs/same.env > ./.env



.PHONY: to_prod
to_prod:
	@echo "===========	to_prod	============="
	cat ./envs/prod.env ./envs/same.env > ./.env



.PHONY: start
start:
	@echo "===========	start	============="
	@docker-compose \
		-f ./$(DOCKER_COMPOSE_EXPORT_FILE) \
		start



.PHONY: restart
restart:
	@echo "===========	restart	============="
	@docker-compose \
		-f ./$(DOCKER_COMPOSE_EXPORT_FILE) \
		restart



.PHONY: stop
stop:
	@echo "===========	stop	============="
	@docker-compose \
		-f ./$(DOCKER_COMPOSE_EXPORT_FILE) \
		stop



.PHONY: container_list
container_list: 
		docker ps --format "table {{.ID}}\t{{.Image}}\t{{.CreatedAt}}\t{{.Status}}\t{{.Ports}}"



.PHONY: dev_nginx
dev_nginx: stop to_dev export_config_nginx
	@echo "===========	dev nginx	============="
	@docker-compose \
		-f ./$(DOCKER_COMPOSE_EXPORT_FILE) \
		up \
		-d \
		--build \
		--force-recreate



.PHONY: dev_caddy
dev_caddy: stop to_dev export_config_caddy
	@echo "===========	dev caddy	============="
	@docker-compose \
		-f ./$(DOCKER_COMPOSE_EXPORT_FILE) \
		up \
		-d \
		--build \
		--force-recreate



.PHONY: prod_nginx
prod_nginx: stop to_prod export_config_nginx
	@echo "===========	prod  nginx	 ============="
	@docker-compose \
		-f ./$(DOCKER_COMPOSE_EXPORT_FILE) \
		up \
		-d \
		--build \
		--force-recreate



.PHONY: prod_caddy
prod_caddy: stop to_prod export_config_caddy
	@echo "===========	prod  caddy	 ============="
	@docker-compose \
		-f ./$(DOCKER_COMPOSE_EXPORT_FILE) \
		up \
		-d \
		--build \
		--force-recreate
