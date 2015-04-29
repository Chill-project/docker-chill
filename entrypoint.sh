#!/bin/bash
/usr/bin/php /var/www/chill/app/console doctrine:migrations:migrate --no-interaction
/usr/bin/php /var/www/chill/app/console assetic:dump
/usr/bin/php /var/www/chill/app/console assets:install
/usr/sbin/apache2ctl -D FOREGROUND
