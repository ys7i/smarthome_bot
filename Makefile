# makeを打った時のコマンド
.DEFAULT_GOAL := help

.PHONY: up
up:
	docker compose up -d

.PHONY: down
down:
	docker compose down

.PHONY: build
build:
	docker compose build

.PHONY: logs
logs:
	docker compose logs -f

.PHONY: ps
ps:
	docker compose ps

.PHONY: bundle-install
bundle-install:
	docker compose exec bot bundle install

.PHONY: migrate
migrate:
	docker compose exec bot bundle exec rails db:migrate

.PHONY: console
console:
	docker compose exec bot bundle exec rails c

.PHONY: mysql
mysql:
	docker compose exec db mysql -u root -p

.PHONY: enter
enter:
	docker compose exec bot bash

.PHONY: restart
restart: down up

.PHONY: credential
credential:
	docker compose exec bot rails credentials:edit
