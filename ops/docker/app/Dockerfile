FROM php:7.3.3-fpm-alpine3.8

LABEL maintainer="eden.reich@gmail.com"

ARG DOCKER_PATH=ops/docker

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN apk update

RUN apk add --no-cache nginx supervisor

RUN apk add --no-cache composer nodejs nodejs-npm

RUN docker-php-ext-install pdo_mysql

RUN mkdir /run/nginx

ADD ${DOCKER_PATH}/app/config/php /etc/php7/conf.d/

ADD ${DOCKER_PATH}/app/config/nginx /etc/nginx/conf.d/

COPY ${DOCKER_PATH}/app/config/supervisor/supervisor.d /etc/supervisor.d
COPY ${DOCKER_PATH}/app/config/supervisor/supervisord.conf /etc/supervisord.conf

VOLUME /app

WORKDIR /app

COPY src /app

RUN composer install --no-dev -o

EXPOSE 80

CMD ["/usr/bin/supervisord", "--nodaemon", "-c", "/etc/supervisord.conf"]