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

echo "downloading latest composer.json file"
wget -O src/code/composer.json https://github.com/Chill-project/Standard/raw/master/composer.json

echo "installing depedencies"
php composer.phar install \
   --working-dir ./src/code \
   --no-interaction 

