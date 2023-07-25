SHELL    = /bin/bash
ARGUMENT = $(arg)
APP		 = $(app)
STEP	 = $(step)
EXEC_APP = docker-compose exec -it ${APP}

.PHONY: default
default: help

.PHONY: help
help:
	@echo 'Management commands titipjual:'
	@echo
	@echo 'Usage:'
	@echo '    make shellapp                                     Execute shell in app container.'
	@echo '    make logsall                                      Following log for all container.'
	@echo


.PHONY: run
run:
	docker-compose up -d

.PHONY: shellapp
shellapp:
	${EXEC_APP} /bin/bash

.PHONY: logsall
logsall:
	docker-compose logs -f

.PHONY: migratenew
migratenew:
	${EXEC_APP} php artisan make:migration ${ARGUMENT}

.PHONY: migrateup
migrateup:
	${EXEC_APP} php artisan migrate

.PHONY: migratedown
migratedown:
	${EXEC_APP} php artisan migrate:rollback --step=${STEP}

.PHONY: configclear
configclear:
	${EXEC_APP} php artisan config:clear

.PHONY: createuser
createuser:
	${EXEC_APP} php artisan make:filament-user

.PHONY: seeder
seeder:
	${EXEC_APP} php artisan db:seed --class=DatabaseSeeder

.PHONY: resource
resource:
	${EXEC_APP} php artisan make:filament-resource ${ARGUMENT} --generate

.PHONY: exec
exec:
	${EXEC_APP} ${ARGUMENT}
