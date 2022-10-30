FROM ubuntu:22.04

ENV TZ=Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
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
    && mkdir -p /srv/www \
    && curl https://wordpress.org/latest.tar.gz | tar zx -C /srv/www

ENTRYPOINT [ "apache2ctl", "-D", "FOREGROUND" ]

COPY wordpress.conf /etc/apache2/sites-available/
COPY wp-config.php /srv/www/wordpress/

RUN a2ensite wordpress \
    && a2enmod rewrite \
    && a2dissite 000-default


EXPOSE 80
