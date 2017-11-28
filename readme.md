Base docker image for PHP applications
======================================
[![Docker Build Status](https://img.shields.io/docker/build/prog/php.svg?style=flat-square)](https://hub.docker.com/r/prog/php/)
[![Docker Build Status](https://img.shields.io/docker/automated/prog/php.svg?style=flat-square)](https://hub.docker.com/r/prog/php/)
[![Docker Build Status](https://img.shields.io/docker/pulls/prog/php.svg?style=flat-square)](https://hub.docker.com/r/prog/php/)
[![Docker Build Status](https://img.shields.io/docker/stars/prog/php.svg?style=flat-square)](https://hub.docker.com/r/prog/php/)

Alpine based docker image with Apache (prefork) & PHP module.


Supported tags / versions
-------------------------

- `7.1-apache2.4-alpine3.6` `7.1-apache-alpine` `7-apache-alpine`  
  [![](https://images.microbadger.com/badges/image/prog/php:7.1-apache2.4-alpine3.6.svg)](https://microbadger.com/images/prog/php:7.1-apache2.4-alpine3.6)

- `5.6-apache2.4-alpine3.6` `5.6-apache-alpine` `5-apache-alpine`  
  [![](https://images.microbadger.com/badges/image/prog/php:5.6-apache2.4-alpine3.6.svg)](https://microbadger.com/images/prog/php:5.6-apache2.4-alpine3.6)

Customization
-------------

Some helper scripts are bundled with the image to make it easier to setup and customize.

### Install PHP modules

This image comes with no extra php modules. You need to add all modules required by your application yourself.
A helper script is provided for this purpose:

```bash
webserver--add-php-mod [list of php modules]
```

```Dockerfile
RUN webserver--add-php-mod \
    cli gd mbstring pdo session ...  
```

### Enable Apache modules

Only minimal set of apache modules are enabled by default.
Use the helper script to enable required modules in apache config file:

```bash
webserver--enable-a2-mod [list of apache modules]
```

```Dockerfile
RUN webserver--enable-a2-mod \
    deflate filter rewrite ...
```

### Change document root

Apache is set to serve `/app` directory by default.
You can change it by running:

```bash
webserver--set-docroot [path]
```

```Dockerfile
RUN webserver--set-docroot /app/docroot
```

### Initialization script

The entrypoint is set to run an initialization script (`/usr/bin/webserver--init`) before executing Apache when
container is started. Initialization script is empty by default. You can add your own instructions there or replace
the whole file.

The helper script can be used to add instructions into the initialization script:

```bash
webserver--on-init [script lines]
```

```Dockerfile
RUN webserver--on-init \
   '# My application initialization' \
   'echo "Starting my awesome application!"' \
   'chmod 777 /app/temp'
```


Full usage example
------------------

Add the `Dockerfile` to your project and edit it to your needs:  

```Dockerfile
FROM prog/php:7.1-apache2.4-alpine3.6

## install required php modules
RUN webserver--add-php-mod cli iconv json mbstring pdo_mysql session sqlite3 tokenizer

## enable required apache modules
RUN webserver--enable-a2-mod rewrite

## set document root
RUN webserver--set-docroot /app/public

## set container's initialization script
RUN webserver--on-init \
   'chmod 777 /app/temp /app/log /app/sessions' \
   'if [ "$''{APP__DB_MIGRATIONS}" ]; then' \
   '	/app/bin/db-migrations $''{APP__DB_MIGRATIONS}' \
   'fi'

## copy application into image, create necessary directories
WORKDIR /app
COPY vendor vendor
COPY bin bin
COPY src src
COPY public public
RUN mkdir log temp sessions

## declare volumes, expose ports
VOLUME /app/log
VOLUME /app/sessions
EXPOSE 80
```

Build your image:

```bash
docker build . -t my-awesome-app
```

Run it:

```bash
docker run \
  -e 'APP__DB_DSN=mysql:host=localhost;dbname=database' \
  -e 'APP__DB_USER=user' \
  -e 'APP__DB_PASSWORD=password' \
  -e 'APP__DB_MIGRATIONS=main' \
  -e 'APP__DEBUG_MODE=off' \
  -v 'my-awesome-app__log:/app/log' \
  -v 'my_awesome-app__sessions:/app/sessions' \
  -p '80:80' \
  my-awesome-app
```
