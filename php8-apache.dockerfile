FROM php:8.0-apache
MAINTAINER João Silva

RUN apt-get update && apt-get install -y \
    vim \
    git \
    wget \
    zip

RUN docker-php-ext-install pdo_mysql mysqli

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

#sendmail
RUN wget https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64
RUN chmod +x mhsendmail_linux_amd64
RUN mv mhsendmail_linux_amd64 /usr/local/bin/mhsendmail
RUN echo "sendmail_path = '/usr/local/bin/mhsendmail --smtp-addr=mailhog:1025'" >> /usr/local/etc/php/conf.d/sendmail.ini

RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

WORKDIR /www

RUN a2enmod rewrite
RUN a2enmod ssl

EXPOSE 80
EXPOSE 443