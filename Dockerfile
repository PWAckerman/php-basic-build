FROM ubuntu:trusty
LABEL maintainer "patrickackerman@gmail.com"

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN export TERM=xterm
RUN apt-get update && \
  apt-get -y install supervisor nano git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apc php5-mcrypt && \
  echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Add image configuration and scripts
VOLUME ["/contents"]
COPY /contents /contents

WORKDIR /contents
RUN chmod 775 *
WORKDIR /

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Configure /app folder with sample app
ADD /app /app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M

# Add volumes for MySQL
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]

RUN ls /var/www/html

EXPOSE 80 3306
ENTRYPOINT ["/contents/run.sh"]
