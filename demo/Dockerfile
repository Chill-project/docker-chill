FROM ubuntu:14.04
MAINTAINER <julien.fastre@champs-libres.coop>

RUN apt-get update && apt-get -y install apache2 php5 php5-curl php5-intl php5-pgsql git

#apache configuration
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2


#import standard
ADD src/ /var/www/chill

#load parameters for chill
ADD app/config/config.yml /var/www/chill/app/config/config.yml
ADD app/config/parameters.yml /var/www/chill/app/config/parameters.yml

#create folders and set permissions
RUN mkdir -p /var/www/chill/app/cache/prod && \
   chown www-data:www-data /var/www/chill/app/cache/prod && \
   ln -sf /dev/stdout /var/www/chill/app/ && \ 
   chown -R www-data:www-data /var/www/chill/app/logs

#install assets
CMD /usr/bin/php /var/www/chill/app/console assets:install --env=prod
CMD /usr/bin/php /var/www/chill/app/console assetic:dump --env=prod

#customize apache config
ADD apache2.conf /etc/apache2/apache2.conf
ADD chill.conf /etc/apache2/sites-available/000-default.conf
ADD entrypoint.sh /var/entrypoint.sh
RUN chmod o+x /var/entrypoint.sh

#link log to console
RUN ln -sf /dev/stdout /var/log/apache2/access.log
RUN ln -sf /dev/stderr /var/log/apache2/error.log

EXPOSE 80
EXPOSE 443

CMD ["/var/entrypoint.sh"]

