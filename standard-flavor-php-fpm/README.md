Chill "Standard flavor"
=======================

What is Chill ?
----------------

Chill is a software for social workers. It helps them by achieving two goals : 

- having all information about the person accompanyied on their eyes ;
- accelerating administrative tasks.

More information: http://chill.social. Documentation is available at http://docs.chill.social

This is the standard flavor with main bundleds. This image is not far to be ready for production.

Building
========

```
docker build --tag=standard-fpm .
```

Running
=======

Database
--------

Start a database :

```
docker run -P --name chill_db_temp chill/database
```

Starting php-fpm
------------------

Start this container with a link to database :

- if you build on previous step with the tag `standard-fpm`:

```
docker run --link chill_db_temp:db --name chill_fpm --env "ADMIN_PASSWORD=pass"  --env "SECRET=i_am_not_secret" standard-fpm
```

- if you download from docker hub: 

```
docker run --link chill_db_temp:db --name chill_fpm chill/standard-fpm
```

**Notes**

In the commande above: 

- `chill_db_temp` is the database container's name. You may replace this by the name you give to the database name's container ;
- `db` is the expected database host inside the container. You can override this with adding the ENV parameter `DATABASE_HOST` (Example: `--env "DATABASE_HOST=another_host`)
- if you want the container to be destroyed on shut-down (all data will be lost), add `--rm` in the command

The container should start, run migrations files on database, dump assets, then run php-fpm and wait for connections.

**Available options**

Those environnement variable are available :

- `ADMIN_PASSWORD` (required) : the admin password. 
- `SECRET` (required) : the secret used by the symfony kernel ([explanations](http://symfony.com/doc/current/reference/configuration/framework.html#secret))
- `DATABASE_HOST`: The host to connect the database. Default: `db`
- `DATABASE_NAME`: The database name. Default: `postgres`
- `DATABASE_USER`: The database username. Default: `postgres`
- `DATABASE_PASSWORD`: The database password. Default: `postgres`
- `LOCALE`: The default locale. Default: `fr`

**I want to override templates**

You juste have to [add a volume](https://docs.docker.com/userguide/dockervolumes/) inside the container at `/var/www/chill/app/Resources`. Example : 

```
docker run --env "ADMIN_PASSWORD=abcde" --env "SECRET=123456" --link chill_db_temp:db --name chill_fpm -v /path/to/my/resources/Resources:/var/www/chill/app/Resources:ro chill/standard-fpm
```

[Read the full symfony documentation about overriding templates](http://symfony.com/doc/current/book/templating.html#overriding-bundle-templates).


Nginx
-----

Then start a nginx container to serve the content. We use the [standard nginx image](https://hub.docker.com/_/nginx/), with an adaptation of the configuration. You can download [our configuration file from the repository](https://raw.githubusercontent.com/Chill-project/docker-chill/master/standard-flavor-php-fpm/nginx.conf)

```
# download the sample configuration file
wget https://raw.githubusercontent.com/Chill-project/docker-chill/master/standard-flavor-php-fpm/nginx.conf
# run the container
docker run --link chill_fpm:chill_php --name nginx -p 8080:80 -v `pwd`/nginx.conf:/etc/nginx/nginx.conf --volumes-from chill_fpm nginx
```

**Notes**

- in `--link` argument, `chill_fpm` match the container's name for the php-fpm code (launched the previous step)
- in `--link` argument, `chill_php` match the expected container name in `nginx.conf` ([see here](https://github.com/Chill-project/docker-chill/blob/master/standard-flavor-php-fpm/nginx.conf#L45)) ;
- you can replace `--name nginx` by any name you want ;
- `-v` argument replace the nginx.conf file in the standard nginx image with the custom configuration
- `--volumes-from` import volumes from the fpm container. This is required to let nginx serve assets (javascripts, images, css, ...)
- in the command above, the exported port is `8080`. You can stick to port `80` if you prefer by removing `-p 8080:80`

Chill should be accessible on http://localhost:8080 (if you exposed port 8080).


Running console commands
========================

You can run command into a running container using `docker exec`. Here is an example on how to adding fixtures (running `php app/console doctrine:fixtures:load`) :

```
# assuming that the container's name is 'chill_php':
docker exec -ti chill_php /usr/local/bin/php /var/www/chill/app/console doctrine:fixtures:load --env=prod
```

Stopping the containers
=======================

You can stop properly the container using 

```
# replace eventually by the name you assigned to your containers
docker stop nginx
docker stop chill_fpm
docker stop chill_db_temp
```

Removing the containers
========================

This command will destroy your containers **and removing all data from your hard disk**.

```
# replace eventually by the name you assigned to your containers
docker rm --volumes nginx
docker rm --volumes chill_fpm
docker rm --volumes chill_db_temp
```

Building
========

You may build the container using 

```
docker build --tag=MY_TAG .
```

What do building ?
------------------

The build process (describe in Dockerfile) :

- compile php extension required for this app ;
- install [composer](https://getcomposer.org) ;
- create an empty project in /var/www/chill (inside the container) ;
- install the dependencies (php packages) using composer ;
- install the entry point (`entrypoint.sh`)

The packages are downloaded from http://package.chill.social, to avoid limitation on github API.

Building app locally
---------------------

This will install composer locally, download project template (in src/code directory), copy parameters.yml file and download depedencies in the directory `src/code`.

If `src/code` is present, the `code` directory will be renamed with current date.

This process is useful to compare packages downloaded during build from [the mirror](http://packages.chill.social) and those which should be downloaded from packagist.

Compare version from packagist and version from mirror
======================================================

This can be useful if you want to check that you have the last version packaged into your image.

From a running container
------------------------

```
docker exec -ti chill_fpm /usr/local/bin/php /usr/local/bin/composer show -i
```

Override entrypoint / run a specific container
----------------------------------------------

```bash
# run a container with bin/bash
docker run --rm --entrypoint=/bin/bash -it chill/demo-flavor
```

Then, inside the container, print the packages installed :
```bash
composer show -i
```

Then, you may exit from the container: 

```bash
exit
```

Building locally
----------------

From your machine, you may build the project locally : 

```bash
./build-project-locally.sh
```

This will build the project in src/code, removing the repositories from composer.json.

Then, you may see and compare the packages version using composer again : 

```bash
php composer.phar show -i --working-dir=src/code 
```

Results
--------

Both commands should print the following :

```
champs-libres/composer-bundle-migration 1.0.6              Move DoctrineMigrations files from installed bundle to...
chill-project/activity                  dev-master c7962c8 This bundle extend chill for recording the different a...
chill-project/custom-fields             dev-master add762e This bundle allow to add custom fields on entities.
chill-project/main                      dev-master 1b31cb3 The main bundle for the Chill App
chill-project/person                    dev-master 9decbf1 A bundle to deal with persons
chill-project/report                    dev-master 1f58e60 The bundle for reports
doctrine/annotations                    v1.2.6             Docblock Annotations Parser
doctrine/cache                          v1.4.1             Caching library offering an object-oriented API for ma...
doctrine/collections                    v1.3.0             Collections Abstraction library
doctrine/common                         v2.5.0             Common Library for Doctrine projects
doctrine/data-fixtures                  v1.1.1             Data Fixtures for all Doctrine Object Managers
doctrine/dbal                           v2.5.1             Database Abstraction Layer
doctrine/doctrine-bundle                v1.5.1             Symfony DoctrineBundle
doctrine/doctrine-cache-bundle          v1.0.1             Symfony2 Bundle for Doctrine Cache
doctrine/doctrine-fixtures-bundle       dev-master 817c2d2 Symfony DoctrineFixturesBundle
doctrine/doctrine-migrations-bundle     dev-master 238aaa5 Symfony DoctrineMigrationsBundle
doctrine/inflector                      v1.0.1             Common String Manipulations with regard to casing and ...
doctrine/instantiator                   1.0.5              A small, lightweight utility to instantiate objects in...
doctrine/lexer                          v1.0.1             Base library for a lexer that can be used in Top-Down,...
doctrine/migrations                     dev-master c030c0c Database Schema migrations using Doctrine DBAL
doctrine/orm                            v2.5.0             Object-Relational-Mapper for PHP
fzaninotto/faker                        v1.5.0             Faker is a PHP library that generates fake data for you.
jdorn/sql-formatter                     v1.2.17            a PHP SQL highlighting library
kriswallsmith/assetic                   v1.2.1             Asset Management for PHP
monolog/monolog                         1.16.0             Sends your logs to files, sockets, inboxes, databases ...
psr/log                                 1.0.0              Common interface for logging libraries
sensio/distribution-bundle              v3.0.31            Base bundle for Symfony Distributions
sensio/framework-extra-bundle           v3.0.10            This bundle provides a way to configure your controlle...
sensio/generator-bundle                 v2.5.3             This bundle generates code for you
sensiolabs/security-checker             v3.0.1             A security checker for your composer.lock
swiftmailer/swiftmailer                 v5.4.1             Swiftmailer, free feature-rich PHP mailer
symfony/assetic-bundle                  v2.6.1             Integrates Assetic into Symfony2
symfony/monolog-bundle                  v2.7.1             Symfony MonologBundle
symfony/swiftmailer-bundle              v2.3.8             Symfony SwiftmailerBundle
symfony/symfony                         v2.7.3             The Symfony PHP framework
twig/extensions                         v1.2.0             Common additional features for Twig that do not direct...
twig/twig                               v1.20.0            Twig, the flexible, fast, and secure template language...
```

