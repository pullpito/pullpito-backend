# Creation
new-project:
	docker-compose run --rm api rails new . --api --force --database=postgresql --skip-bundle
	docker-compose build
new-database:
	docker-compose run --rm api rails db:create
	docker-compose run --rm api rails db:migrate
	docker-compose run --rm api rails db:seed
# Build
build-images:
	docker-compose down
	rm -f ./tmp/pids/server.pid
	docker-compose build
# Database management
db-migration:
	docker-compose run --rm api rails db:migrate
db-seed:
	docker-compose run --rm api rails db:seed
db-update:
	docker-compose run --rm api rails db:migrate
	docker-compose run --rm api rails db:seed
# Runtime management
project-up:
	docker-compose up -d api
project-down:
	docker-compose down
run-console:
	docker-compose run --rm api bash
run-rails-console:
	docker-compose run --rm api rails c
# Testing
run-tests:
	docker-compose run --rm api bundle exec rspec
# Other
log-monitor:
	tail -f log/development.log
clean-all:
	docker rm $(docker ps -a -q)
	docker rmi $(docker images -q)