FROM php:5.6-cli

MAINTAINER <julien.fastre@champs-libres.coop>

RUN apt-get update && apt-get -y install wget ca-certificates \
   && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc |  apt-key add -

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update && apt-get -y install libicu52 \ 
   libicu-dev \
   g++ \
   postgresql-server-dev-9.4 
RUN docker-php-ext-install intl pdo_pgsql mbstring

#remove unused packages
RUN apt-get remove -y wget libicu-dev \
   g++ \
   && apt-get autoremove -y 

#php configuration
RUN echo "\
[Date] \
date.timezone = Europe/Brussels" \
   >> /usr/local/etc/php/php.ini

#install flavor
ADD  src/code/. /var/www/chill/
ADD parameters.yml /var/www/chill/app/config/parameters.yml
WORKDIR /var/www/chill

ADD entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

EXPOSE 8000

ENTRYPOINT /entrypoint.sh

