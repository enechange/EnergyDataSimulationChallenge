all:

dev:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d

migrate_reset:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml run --rm app rails db:migrate:reset db:seed

down:
	docker-compose down

.PHONY: all dev migrate_reset down
