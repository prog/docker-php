#!/usr/bin/env bash


docker build image -t prog/php:7.1-apache2.4-alpine3.6
docker tag prog/php:7.1-apache2.4-alpine3.6 prog/php:7.1-apache2-alpine
