This container create a chill application

usage :

```
sudo docker run --link chill-db:db -t -i chill-base
```

where chill-db is a postgresql container which have a database called "chill", username "chill" and password "chill", already prepared.

TODO
-----

* dump assetic with prod environment 
* prepare database schema
* allow to override parameters.yml
