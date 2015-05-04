#!/bin/bash

#immediatly exit if a command fails:
set -e

#prepare cache - executed as www-data
sudo -u www-data /usr/bin/php /var/www/chill/app/console cache:clear --env=prod

#migrate
/usr/bin/php /var/www/chill/app/console doctrine:migrations:migrate --no-interaction --env=prod

#dump file
/usr/bin/php /var/www/chill/app/console assetic:dump --env=prod
/usr/bin/php /var/www/chill/app/console assets:install --env=prod

#start apache
/usr/sbin/apache2ctl -D FOREGROUND
