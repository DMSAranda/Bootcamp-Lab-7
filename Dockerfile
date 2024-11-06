FROM php:7.4-fpm AS app-build

# Installing required libraries and php extensions
RUN apt-get update && apt-get install -y libcurl4-openssl-dev libxml2-dev libzip-dev libonig-dev nginx libpng-dev cron
RUN docker-php-ext-install bcmath curl mbstring xml zip gd pdo_mysql

# Change composer home directory
ENV COMPOSER_HOME /composer

# Allow composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Set up an specific composer version
ENV COMPOSERSETUP 2.0.7

# Installing composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copying source code and installing it with composer
ADD products-api/ /var/www/
COPY nginx.conf.local /etc/nginx/nginx.conf
WORKDIR /var/www/
RUN composer install

RUN chmod -R 755 /var/lib/nginx

RUN chown -R www-data:www-data var

# Open nginx port
EXPOSE 8081

# Env variables will be provided on startup, so we need to do a clear-cache and then start NGINX and FastCGI server
CMD composer clear-cache && nginx && printenv | grep -v "no_proxy" >> /etc/environment && cron && php-fpm --nodaemonize --force-stderr
