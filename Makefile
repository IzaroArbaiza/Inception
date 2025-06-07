include src/.env
export

COMPOSE_CMD = docker compose -f src/docker-compose.yml --env-file src/.env

.PHONY: all build up run down restart clean fclean

all: run

build:
	$(COMPOSE_CMD) build --progress=tty

up:
	$(COMPOSE_CMD) up -d

run: build up
	@echo "✅ Todos los contenedores se han iniciado correctamente. Puedes acceder a https://$(DOMAIN_NAME)"

down:
	$(COMPOSE_CMD) down -v

restart: down up

clean:
	@docker stop $$(docker ps -qa) 2>/dev/null || true; \
	docker rm $$(docker ps -qa) 2>/dev/null || true; \
	docker rmi -f $$(docker images -qa) 2>/dev/null || true; \
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true; \
	docker network rm $$(docker network ls -q) 2>/dev/null || true; \
	docker system prune -f --volumes

fclean: clean
	sudo rm -rf /home/iarbaiza/data/mariadb/*
	sudo rm -rf /home/iarbaiza/data/wordpress/*
#clear
	@echo "🗑️  Todo limpio ✅"

