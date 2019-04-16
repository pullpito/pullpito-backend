# Creation
new-project:
	docker-compose run --rm api rails new . --api --force --database=postgresql --skip-bundle
	docker-compose build
new-database:
	docker-compose run --rm api rails db:create
	docker-compose run --rm api rails db:migrate
	docker-compose run --rm api rails db:seed
# Database management
database-migration:
	docker-compose run --rm api rails db:migrate
database-seed:
	docker-compose run --rm api rails db:seed
# Runtime management
project-up:
	docker-compose up -d
project-down:
	docker-compose down
# Testing
run-tests:
	docker-compose run --rm api bundle exec rspec
# Other
log-monitor:
	tail -f log/development.log
clean-all:
	docker rm $(docker ps -a -q)
	docker rmi $(docker images -q)