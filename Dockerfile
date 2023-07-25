FROM php:8.2-fpm

ARG APP_NAME
ENV APP_NAME=$APP_NAME

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpq-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    iputils-ping

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN CFLAGS="-I/usr/src/php" docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd xml zip iconv simplexml xmlreader

RUN apt-get purge -y --auto-remove libxml2-dev \
	&& rm -r /var/lib/apt/lists/*

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -d /home/laravel laravel
RUN mkdir -p /home/laravel/.composer && \
    chown -R laravel:laravel /home/laravel

# Set working directory
WORKDIR /var/www/${APP_NAME}

USER laravel
