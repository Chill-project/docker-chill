#!/bin/bash
sudo -u www-data /usr/bin/php /var/www/chill/app/console cache:clear --env=prod
/usr/bin/php /var/www/chill/app/console doctrine:migrations:migrate --no-interaction --env=prod
/usr/bin/php /var/www/chill/app/console assetic:dump --env=prod
/usr/bin/php /var/www/chill/app/console assets:install --env=prod
/usr/sbin/apache2ctl -D FOREGROUND
