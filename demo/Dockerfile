FROM php:5.6-cli

MAINTAINER <julien.fastre@champs-libres.coop>

RUN apt-get update && apt-get -y install curl zlib1g-dev \
    && docker-php-ext-install zip

RUN curl -sS https://getcomposer.org/installer | php \
      && mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/chill

RUN composer create-project chill-project/standard /var/www/chill/ --stability=dev --no-dev --no-install --no-interaction

ADD composer.json /var/www/chill/composer.json

RUN composer install --working-dir /var/www/chill --no-dev --no-interaction


#load parameters for chill
ADD app/config/config.yml /var/www/chill/app/config/config.yml
ADD app/config/parameters.yml /var/www/chill/app/config/parameters.yml

#create folders and set permissions
RUN mkdir -p /var/www/chill/app/cache/prod && \
   chmod 666 /var/www/chill/app/cache/prod && \
   ln -sf /dev/stdout /var/www/chill/app/ && \ 
   chmod 666 /var/www/chill/app/logs

#install assets NOT POSSIBLE because pdo_postgres is required !
#RUN php /var/www/chill/app/console assets:install --env=prod
#RUN php /var/www/chill/app/console assetic:dump --env=prod

VOLUME /var/www/chill

