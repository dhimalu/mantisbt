FROM ubuntu:22.04
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y apache2
RUN apt-get install -y apache2-utils
RUN apt-get install -y php php-cli php-fpm php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath
RUN a2enmod rewrite
COPY mantisentrypoint.sh /mantisentrypoint.sh
RUN chmod 777 /mantisentrypoint.sh
COPY . /var/www/html
RUN chown -R www-data:www-data /var/www/html
ENTRYPOINT [ "/mantisentrypoint.sh" ]
EXPOSE 80
