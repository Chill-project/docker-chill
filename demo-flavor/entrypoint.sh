#!/bin/bash

#immediatly exit if a command fails:
#set -e

#prepare cache
php /var/www/chill/app/console --env=prod cache:clear

#migrate
php /var/www/chill/app/console doctrine:migrations:migrate --no-interaction --env=prod

#prepare assets
php /var/www/chill/app/console --env=prod assets:install
php /var/www/chill/app/console --env=prod assetic:dump

#install fixtures
php /var/www/chill/app/console doctrine:fixtures:load --no-interaction --env=prod

php app/console server:run --env=prod 0.0.0.0:8000 

