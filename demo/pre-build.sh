#!/bin/bash

#create a src directory without installing depedencies
composer create-project chill-project/standard src/ --stability=dev --no-dev --no-install --no-interaction

#move composer.json file into new directory
cp composer.json src/composer.json
#cp composer.lock src/.

#install deps
composer  install --working-dir src --no-dev --no-interaction

#install assets
#/usr/bin/php src/app/console assets:install --env=prod
#/usr/bin/php src/app/console assetic:dump --env=prod

echo "The source of the core program are ready, you can now build your image with docker build\n"
