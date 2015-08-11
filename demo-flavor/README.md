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

Building
========

Before building, you must run the pre-build script using 

```
./pre-build.sh
```

This will install composer locally, download project template (in src/code directory), copy parameters.yml file and download depedencies.

Then, you may build the container using 

```
docker build --tag=MY_TAG .
```

Why do we need a pre-build script ?
------------------------------------

This is due to github api limitations: if downloaded during building phase itself, the limitations are reached and the build fails, as there is no way to add a secret token securely during the building phase.

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
