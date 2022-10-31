FROM ubuntu:22.04

ENV TZ=Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get update \
    && apt-get install -y \
    apache2 \
    ghostscript \
    libapache2-mod-php \
    php \
    php-bcmath \
    php-curl \
    php-imagick \
    php-intl \
    php-json \
    php-mbstring \
    php-mysql \
    php-xml \
    php-zip \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /srv/www \
    && curl https://wordpress.org/latest.tar.gz | tar zx -C /srv/www \
    && chown -R www-data:www-data /srv/www

ENTRYPOINT [ "apache2ctl", "-D", "FOREGROUND" ]

COPY --chown=www-data:www-data wordpress.conf /etc/apache2/sites-available/
COPY --chown=www-data:www-data wp-config.php /srv/www/wordpress/

RUN a2ensite wordpress \
    && a2enmod rewrite \
    && a2dissite 000-default

EXPOSE 80
