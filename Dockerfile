FROM --platform=linux/arm64 composer:latest as composer

WORKDIR /app
COPY composer.* ./
RUN composer install --no-dev --no-scripts --no-autoloader

FROM --platform=linux/arm64 php:8.3-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpq-dev \
    libonig-dev \
    libicu-dev

# Install PHP extensions
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    zip \
    intl \
    opcache

# Install Redis extension
RUN pecl install redis && docker-php-ext-enable redis

WORKDIR /var/www

# Copy composer files
COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY --from=composer /app/vendor/ ./vendor/
COPY . .

# Install dependencies and generate autoload files
RUN composer dump-autoload --optimize \
    && mkdir -p var/cache var/log \
    && chown -R www-data:www-data var

EXPOSE 9000

CMD ["php-fpm"]
