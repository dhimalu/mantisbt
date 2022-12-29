FROM ubuntu:22.04
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y apache2
RUN apt-get install -y apache2-utils
RUN set -xe \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
        # PHP dependencies
        libfreetype6-dev libpng-dev libjpeg-dev libpq-dev libxml2-dev \
        # New in PHP 7.4, required for mbstring, see https://github.com/docker-library/php/issues/880
        libonig-dev \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install gd mbstring mysqli soap \
    && rm -rf /var/lib/apt/lists/* \
    && a2enmod rewrite
#COPY ./mantisentrypoint.sh /usr/local/bin/mantisentrypoint.sh
#RUN chmod 777 /usr/local/bin/mantisentrypoint.sh
COPY . /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN rm -rf /etc/apache2/sites-enabled/000-default.conf
#ENTRYPOINT [ "mantisentrypoint.sh" ]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
