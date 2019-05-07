all: build migrate_reset up

build:
	docker-compose -f docker-compose.yml build app

up:
	docker-compose -f docker-compose.yml up -d

dev:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d

migrate_reset:
	docker-compose -f docker-compose.yml run --rm app rails db:migrate:reset db:seed

down:
	docker-compose down

.PHONY: all build dev migrate_reset down
