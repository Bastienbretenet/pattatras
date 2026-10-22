# syntax=docker/dockerfile:1

FROM dunglas/frankenphp:1-php8.4

RUN install-php-extensions opcache zip \
    && echo "opcache.revalidate_freq=0" > "$PHP_INI_DIR/conf.d/zz-dev.ini"

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Conteneur lancé en non-root : port > 1024 et dossiers de travail Caddy/Composer dans /tmp.
ENV SERVER_NAME=:8000 \
    XDG_CONFIG_HOME=/tmp/config \
    XDG_DATA_HOME=/tmp/data \
    COMPOSER_HOME=/tmp/composer

WORKDIR /app

# Point de montage des volumes vendor/ et var/ : Docker reprend ce propriétaire à leur création.
RUN mkdir -p vendor var && chown 1000:1000 vendor var

EXPOSE 8000

CMD ["sh", "-c", "composer install --no-interaction --no-progress && exec frankenphp run --config /etc/frankenphp/Caddyfile --adapter caddyfile"]
