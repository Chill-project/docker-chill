Demo flavor
===========

This demo allow to run a demo version of chill software. It uses the built-in php server. The database must be run in a separate container. Fixtures are added on startup.

This container is for testing purpose, and new data are created during startup.

User created
------------

The user's login created are : 

- center a_social
- center a_administrative
- center a_direction
- center b_social 
- center b_administrative
- center b_direction
- multi_center
- admin

The password is always 'password' (without quotes).

Running
=======

Before running, you must have a `chill\database` container running : 

```
docker run --rm --name=MY_DB_NAME chill/database
```

Then, you may run the container using :

```
docker run --rm --link MY_DB_NAME:db -p 8989:8000 --name=MY_CHILL_NAME MY_TAG
```

replacing MY_DB_NAME and MY_TAG by your container's db name and your build tag, respectively. (**note** : the db container **must** be named `db`, as it is hardcoded in parameters.yml).

Then, you will reach the container by typing `http://localhost:8989` in your browser.

**note** : the `--rm` tag create removable container, which are completely destroyed when you stop the instance.  

Stopping the containers
=======================

You can stop properly the container using 

```
docker stop MY_CHILL_NAME
docker stop MY_DB_NAME
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
-----------------------------------------------------

```bash
# run a container with bin/bash
docker run --rm --entrypoint=/bin/bash -it chill/demo-flavor
```

Then, inside the container, print the packages installed :
```bash
composer show -i
```

This should print the following :

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

Then, you may exit from the container: 

```bash
exit
```

From your machine, you may build the project locally : 

```bash
./build-project-locally.sh
```

This will build the project in src/code, removing the repositories from composer.json.

Then, you may see and compare the packages version using composer again : 

```bash
php composer.phar show -i --working-dir=src/code 
```


