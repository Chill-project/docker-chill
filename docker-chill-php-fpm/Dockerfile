FROM php:5.6-fpm

MAINTAINER <julien.fastre@champs-libres.coop>

RUN apt-get update && apt-get -y install wget ca-certificates \
   && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc |  apt-key add -

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update && apt-get -y install libicu52 \ 
   libicu-dev \
   g++ \
   postgresql-server-dev-9.4 
RUN docker-php-ext-install intl pdo_pgsql

#remove unused packages
RUN apt-get remove -y wget ca-certificates libicu-dev \
   g++ \
   && apt-get autoremove -y 
# the image does not work if this is added...
#   && AUTO_ADDED_PACKAGES=`apt-mark showauto` \
#   && apt-get remove --purge -y $AUTO_ADDED_PACKAGES

#php configuration
RUN echo "[Date] \
date.timezone = Europe/Brussels" \
> /usr/local/etc/php/php.ini


ADD entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

ENTRYPOINT /entrypoint.sh

#CMD ["php-fpm"]

