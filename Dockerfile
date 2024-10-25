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

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy composer files first
COPY composer.json composer.lock* ./

# Set environment to dev by default (override in production)
ARG APP_ENV=dev

# Install dependencies
RUN if [ "$APP_ENV" = "prod" ]; then \
        composer install --no-dev --optimize-autoloader --no-scripts; \
    else \
        composer install --optimize-autoloader --no-scripts; \
    fi

# Copy the rest of the application
COPY . .

# Create var directory and set permissions
RUN mkdir -p var/cache var/log \
    && composer dump-autoload --optimize \
    && chown -R www-data:www-data var

EXPOSE 9000

CMD ["php-fpm"]
