FROM nginx:alpine

# update dependencies
RUN apk update && apk upgrade && \
    # tools
    apk add busybox-extras vim supervisor htop \
    # custom module for libjpeg and libpng
    freetype-dev libjpeg-turbo-dev libpng-dev \
    # common modules for image processing
    php8 php8-fpm php8-phar php8-mbstring php8-gd php8-fileinfo php8-pecl-imagick-dev \
    # database module
    php8-pdo php8-pdo_mysql php8-pdo_pgsql php8-pdo_odbc php8-pecl-mongodb php8-pecl-redis php8-pgsql php8-mysqli

# install composer (if needed)
# RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Configure webserver
COPY docker/default.conf /etc/nginx/conf.d/default.conf
COPY docker/www.conf /etc/php8/php-fpm.d/www.conf

# Copy supervisord config
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install the code (index.php)
COPY index.php /usr/share/nginx/html

# Start nginx and php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# health check, ignore if use kubernetes
#HEALTHCHECK --timeout=30s CMD curl --silent --fail http://127.0.0.1
