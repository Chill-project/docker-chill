#running

docker run --rm --name=chill-php-fpm --volumes-from=chill-code-demo --link chill-db:db chill-php-fpm

where : 

- chill-code-demo : a container with code demo
- chill-db : a container instance of docker-chill-db

## connect in a bash 

```
docker run --rm --name=chill-php-fpm --volumes-from chill-code-demo --link chill-db:db -it --entrypoint=/bin/bash chill-php-fpm -s
```
