#!/bin/bash

#immediatly exit if a command fails:
#set -e

#prepare cache
php /var/www/chill/app/console cache:clear --env=prod

#migrate
php /var/www/chill/app/console doctrine:migrations:migrate --no-interaction --env=prod

#prepare assets
php /var/www/chill/app/console assetic:dump --env=prod
php /var/www/chill/app/console assets:install --env=prod

php-fpm
