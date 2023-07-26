# BWI Kong - Laravel Passport POC


## How to start local development

### 1st time running
- Bring up database, laravel app & Nginx first, `docker-compose up -d db dashboard passport nginx`
- Wait until database up and running, then `docker-compose up -d kong-migrate konga-migrate`
- Wait until konga & kong migration finish, then bring the rest service `docker-compose up -d`
- Execute composer install to each app, `make exec app=passport args="composer install"` & `make exec app=dashboard args="composer install"`
- Execute laravel migration to each app, `make exec app=passport args="php artisan migrate"` & `make exec app=dashboard args="php artisan migrate"`
- Create new filament user, `make exec app=dashboard args="php artisan make:filament-user"`

### next time running
- `docker-compose up -d`
- If there's new migration, `make exec app=passport args="php artisan migrate"` & `make exec app=dashboard args="php artisan migrate"`