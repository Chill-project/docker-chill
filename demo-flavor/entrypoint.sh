#!/bin/bash

#immediatly exit if a command fails:
#set -e

#prepare cache
php /var/www/chill/app/console cache:clear 

#migrate
php /var/www/chill/app/console doctrine:migrations:migrate --no-interaction 

#prepare assets
php /var/www/chill/app/console assetic:dump
php /var/www/chill/app/console assets:install 

php app/console server:run
