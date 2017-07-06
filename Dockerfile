FROM php:5.6-apache
MAINTAINER Fernando Barbosa <fbcbarbosa@gmail.com>
ARG NR_INSTALL_KEY

# Install New Relic
RUN apt-get update 
RUN apt-get -yqq install wget
RUN apt-get -yqq install python-setuptools
RUN easy_install pip
RUN mkdir -p /opt/newrelic

WORKDIR /opt/newrelic
RUN wget -r -nd --no-parent -Alinux.tar.gz \
    http://download.newrelic.com/php_agent/release/ >/dev/null 2>&1 \
    && tar -xzf newrelic-php*.tar.gz --strip=1
ENV NR_INSTALL_SILENT true
RUN bash newrelic-install install

RUN pip install newrelic-plugin-agent
RUN mkdir -p /var/log/newrelic
RUN mkdir -p /var/run/newrelic

WORKDIR /var/www/html
ENV YOURLS_VERSION 1.7.1
RUN curl -o /tmp/YOURLS-$YOURLS_VERSION.tar.gz -L https://github.com/YOURLS/YOURLS/archive/$YOURLS_VERSION.tar.gz && \
    tar -zxf /tmp/YOURLS-$YOURLS_VERSION.tar.gz --strip-components=1 && \
    rm /tmp/YOURLS-$YOURLS_VERSION.tar.gz && \
    docker-php-ext-install pdo_mysql && \
    a2enmod rewrite && \
    rm *.html *.md *.txt

COPY htaccess .htaccess
COPY index.php ./index.php
COPY config.php ./user/config.php
