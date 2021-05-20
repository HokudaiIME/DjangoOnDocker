PYTHON_CMD=python
POETRY_CMD=poetry
CONTAINER_API=django
MANAGE_FILE=manage.py
PROD_DOCKER_COMPOSE_FILE=docker-compose.prod.yml
DB_USER=django_db_user
DB_NAME=django_db
DB_API=postgres
DB_CMD=psql

python_startapp:
	@echo "python"
	docker-compose exec $(CONTAINER_API) $(PYTHON_CMD) $(MANAGE_FILE) startapp api

.PHONY: runserver
runserver:
	@echo "runserver"
	docker-compose exec $(CONTAINER_API) $(PYTHON_CMD) $(MANAGE_FILE) runserver

.PHONY: makemigrations
make-migrations:
	@echo "make migrations"
	docker-compose exec $(CONTAINER_API) $(PYTHON_CMD) $(MANAGE_FILE) makemigrations

.PHONY: migrate
migrate:
	@echo "migrate"
	docker-compose exec $(CONTAINER_API) $(PYTHON_CMD) $(MANAGE_FILE) migrate

.PHONY: enter_postgresql
enter_postgresql:
	@echo "enter postgresql container"
	docker-compose exec $(DB_API) $(DB_CMD) --username=$(DB_USER) --dbname=$(DB_NAME)

.PHONY: prod_up
prod_up:
	@echo "production up"
	docker-compose -f $(PROD_DOCKER_COMPOSE_FILE) up

.PHONY: prod_up_build
prod_up_build:
	@echo "production up contain build"
	docker-compose -f $(PROD_DOCKER_COMPOSE_FILE) up --build

.PHONY: prod_down
prod_down:
	@echo "production down"
	docker-compose -f $(PROD_DOCKER_COMPOSE_FILE) down -v

.PHONY: prod_migrate
prod_migrate:
	@echo "production migrate"
	docker-compose -f $(PROD_DOCKER_COMPOSE_FILE) exec $(CONTAINER_API) $(PYTHON_CMD) $(MANAGE_FILE) migrate --noinput

.PHONY: prod_collect_static
prod_collect_static:
	@echo "production collect static"
	docker-compose -f $(PROD_DOCKER_COMPOSE_FILE) exec $(CONTAINER_API) $(PYTHON_CMD) $(MANAGE_FILE) collectstatic --noinput --clear

