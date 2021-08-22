FROM php:8-fpm-alpine

ARG APCU_VERSION=5.1.20

RUN apk add --no-cache mc

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions \
        xdebug-3.0.4 \
        exif \
        intl \
        gd \
        apcu-${APCU_VERSION} \
        opcache \
        pdo_pgsql \
        pdo_mysql \
        zip  \
        @composer

COPY docker/php/php.ini /usr/local/etc/php/php.ini
COPY docker/php/php-cli.ini /usr/local/etc/php/php-cli.ini
COPY docker/php/conf.d /usr/local/etc/php/conf.d
COPY docker/php/php-fpm.d /usr/local/etc/php-fpm.d

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER=1

ENV PATH="${PATH}:/root/.composer/vendor/bin"

WORKDIR /app


COPY docker/php/entrypoint.sh /usr/local/bin/docker-php-entrypoint
RUN chmod +x /usr/local/bin/docker-php-entrypoint

HEALTHCHECK --interval=5s --timeout=6s --start-period=1s \
    CMD REDIRECT_STATUS=true SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET \
    cgi-fcgi -bind -connect 127.0.0.1:9000 || exit 1
