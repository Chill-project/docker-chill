#!/bin/bash

#install composer if required
if [ ! -f composer.phar ]
then
   echo "installing composer in the directory"
   curl -sS https://getcomposer.org/installer | php
fi

echo "installing project in 'src/code' directory"
if [ -d ./src/code ]
then
   OLD="old_code_`date +%Y%m%d-%H%M`"
   echo "moving old code directory to $OLD"
   mv ./src/code ./src/$OLD
fi
php composer.phar create-project \
   --stability=dev --no-dev --no-install --no-interaction --prefer-dist \
   chill-project/standard ./src/code

cp parameters.yml src/code/app/config/parameters.yml
cp composer.json src/code/composer.json
cp AppKernel.php src/code/app/AppKernel.php

echo "installing depedencies"
export SYMFONY_ENV=prod
php composer.phar install \
   --working-dir ./src/code \
   --no-interaction 

