FROM ubuntu:14.04
MAINTAINER <julien.fastre@champs-libres.coop>

RUN apt-get update && apt-get -y install apache2 php5 php5-curl php5-intl php5-pgsql git

#apache configuration
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

#load chill
WORKDIR /var/www
ADD https://getcomposer.org/installer /var/www/installer
RUN php installer --install-dir=/var/www

RUN /var/www/composer.phar create-project chill-project/standard /var/www/chill --stability=dev

#load parameters for chill
ADD app/config/config.yml /var/www/chill/app/config/config.yml
ADD app/config/parameters.yml /var/www/chill/app/config/parameters.yml

#create folders and set permissions
RUN mkdir -p /var/www/chill/app/cache/prod && chown www-data:www-data /var/www/chill/app/cache/prod
RUN touch /var/www/chill/app/logs/prod.log && chown -R www-data:www-data /var/www/chill/app/logs

#customize apache config
ADD apache2.conf /etc/apache2/apache2.conf
ADD chill.conf /etc/apache2/sites-available/000-default.conf



EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

