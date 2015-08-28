#!/bin/bash

#immediatly exit if a command fails:
set -e

#migrate
php /var/www/chill/app/console doctrine:migrations:migrate --no-interaction --env=prod

#prepare assets
php /var/www/chill/app/console --env=prod assets:install
php /var/www/chill/app/console --env=prod assetic:dump

#install fixtures
php /var/www/chill/app/console doctrine:fixtures:load --no-interaction --env=prod

#prepare cache
php /var/www/chill/app/console --env=prod cache:clear
chown www-data:www-data app/cache/prod -R

php-fpm 

