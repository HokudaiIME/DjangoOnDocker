APP_NAME=api
PYTHON_CMD=python
POETRY_CMD=poetry
CONTAINER_API=django
MANAGE_FILE=manage.py
PROD_DOCKER_COMPOSE_FILE=docker-compose.prod.yml
DB_USER=django_db_user
DB_NAME=django_db
DB_API=postgres
DB_CMD=psql
POETRY_CMD=poetry
DEPENDENCY=null

up:
	@echo "[make command] up containers"
	docker-compose up

.PHONY: python_startapp
up_build:
	@echo "[make command] up containers with building"
	docker-compose up --build

.PHONY: python_startapp
python_startapp:
	@echo "[make command] python"
	docker-compose exec $(CONTAINER_API) $(PYTHON_CMD) $(MANAGE_FILE) startapp $(APP_NAME)

.PHONY: runserver
runserver:
	@echo "[make command] runserver"
	docker-compose exec $(CONTAINER_API) $(PYTHON_CMD) $(MANAGE_FILE) runserver

.PHONY: makemigrations
make_migrations:
	@echo "[make command] make migrations"
	docker-compose exec $(CONTAINER_API) $(PYTHON_CMD) $(MANAGE_FILE) makemigrations

.PHONY: migrate
migrate:
	@echo "[make command] migrate"
	docker-compose exec $(CONTAINER_API) $(PYTHON_CMD) $(MANAGE_FILE) migrate

.PHONY: create_super_user
create_super_user:
	@echo "[make command] create super user"
	docker-compose exec $(CONTAINER_API) $(PYTHON_CMD) $(MANAGE_FILE) createsuperuser

.PHONY: enter_postgresql
enter_postgresql:
	@echo "[make command] enter postgresql container"
	docker-compose exec $(DB_API) $(DB_CMD) --username=$(DB_USER) --dbname=$(DB_NAME)

.PHONY: poetry_add
poetry_add:
	@echo "[make command] poetry add"
	docker-compose exec $(CONTAINER_API) $(POETRY_CMD) add $(DEPENDENCY)

.PHONY: prod_up
prod_up:
	@echo "[make command] production up"
	docker-compose -f $(PROD_DOCKER_COMPOSE_FILE) up

.PHONY: prod_up_build
prod_up_build:
	@echo "[make command] production up contain build"
	docker-compose -f $(PROD_DOCKER_COMPOSE_FILE) up --build

.PHONY: prod_down
prod_down:
	@echo "[make command] production down"
	docker-compose -f $(PROD_DOCKER_COMPOSE_FILE) down -v

.PHONY: prod_migrate
prod_migrate:
	@echo "[make command] production migrate"
	docker-compose -f $(PROD_DOCKER_COMPOSE_FILE) exec $(CONTAINER_API) $(PYTHON_CMD) $(MANAGE_FILE) migrate --noinput

.PHONY: prod_collect_static
prod_collect_static:
	@echo "[make command] production collect static"
	docker-compose -f $(PROD_DOCKER_COMPOSE_FILE) exec $(CONTAINER_API) $(PYTHON_CMD) $(MANAGE_FILE) collectstatic --noinput --clear

