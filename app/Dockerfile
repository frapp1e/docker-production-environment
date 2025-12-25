FROM php:8.2-apache-bullseye

RUN docker-php-ext-install mysqli \
    && docker-php-ext-enable mysqli

# Copiar la aplicación
COPY src/ /var/www/html/

# Exponer puerto
EXPOSE 80

