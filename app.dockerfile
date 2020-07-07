FROM devilbox/php-fpm-7.4:latest

RUN apt-get update && apt-get install -y libmcrypt-dev --no-install-recommends \
    apt-utils \
    git \
    mariadb-client libmagickwand-dev \
    #
    # fonts for japanese characters
    fonts-ipafont fonts-ipafont-gothic fonts-ipafont-mincho \
    libzip-dev zip unzip \
    libxrender1 libfontconfig1 libxext6 fonts-ipafont \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \ 
    && docker-php-ext-install gd exif bcmath pdo_mysql mysqli zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#  Install Node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
