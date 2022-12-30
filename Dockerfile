FROM ubuntu:22.04
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl -y
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:ondrej/php -y
RUN apt-get install -y apache2
RUN apt-get install -y apache2-utils
RUN apt-get install -y php7.2 libapache2-mod-php7.2 php7.2-common php7.2-gmp php7.2-curl php7.2-intl php7.2-mbstring php7.2-xmlrpc php7.2-mysql php7.2-gd php7.2-xml php7.2-cli php7.2-zip
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php7
#RUN apt-get update composer -y
#RUN apt-get composer require backpack/base
#RUN apt-get php artisan backpack:base:install
RUN php composer-setup.php --install-dir=/var/www/html --filename=composer
RUN composer dump-autoload
RUN a2enmod rewrite
#COPY ./mantisentrypoint.sh /usr/local/bin/mantisentrypoint.sh
#RUN chmod 777 /usr/local/bin/mantisentrypoint.sh
RUN rm -rf /var/www/html/*
COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html
#RUN rm -rf /etc/apache2/sites-enabled/000-default.conf
#ENTRYPOINT [ "mantisentrypoint.sh" ]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
