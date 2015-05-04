FROM php:5.6-fpm

MAINTAINER <julien.fastre@champs-libres.coop>

RUN apt-get update && apt-get -y install wget ca-certificates \
   && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc |  apt-key add -

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update && apt-get -y install libicu52 \ 
   libicu-dev \
   g++ \
   postgresql-server-dev-9.4 \
   && docker-php-ext-install intl pgsql

CMD ["php-fpm"]
