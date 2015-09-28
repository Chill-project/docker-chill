<?php 

if (!isset($_ENV['ADMIN_PASSWORD'])) {
   throw new \RuntimeException("The paramater ADMIN_PASSWORD is not defined in the container");
}

if (!isset($_ENV['SECRET'])) {
   throw new \RuntimeException("The paramater SECRET is not defined in the container");
}

$container->setParameter('admin_password', $_ENV['ADMIN_PASSWORD']);
$container->setParameter('secret', $_ENV['SECRET']);
$container->setParameter('database_host', (isset($_ENV['DATABASE_HOST'])) ? $_ENV['DATABASE_HOST'] : 'db' );
$container->setParameter('database_name', (isset($_ENV['DATABASE_NAME'])) ? $_ENV['DATABASE_NAME'] : 'postgres' );
$container->setParameter('database_user', (isset($_ENV['DATABASE_USER'])) ? $_ENV['DATABASE_USER'] : 'postgres' );
$container->setParameter('database_password', (isset($_ENV['DATABASE_PASSWORD'])) ? $_ENV['DATABASE_PASSWORD'] : 'postgres' );
$container->setParameter('locale', (isset($_ENV['LOCALE'])) ? $_ENV['LOCALE'] : 'fr' );

