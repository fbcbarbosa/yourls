FROM php:7.1-apache
MAINTAINER Fernando Barbosa <fbcbarbosa@gmail.com>
ARG NR_INSTALL_KEY 
ARG NR_APP_NAME

# Install New Relic
ENV NR_INSTALL_SILENT true
RUN mkdir -p /opt/newrelic
WORKDIR /opt/newrelic
RUN apt-get update && apt-get -yqq install \
    	python-setuptools \
	wget && \
    easy_install pip && \
    wget -r -nd --no-parent -Alinux.tar.gz \
    http://download.newrelic.com/php_agent/release/ >/dev/null 2>&1 \
    && tar -xzf newrelic-php*.tar.gz --strip=1 && \
    bash newrelic-install install && \
    pip install newrelic-plugin-agent && \
    sed -i '/^newrelic.appname/c\newrelic.appname = "${NR_APP_NAME}"' \
    /usr/local/etc/php/conf.d/newrelic.ini && \
    mkdir -p /var/log/newrelic && \
    mkdir -p /var/run/newrelic

# Install YOURLS
ENV YOURLS_VERSION 1.7.3
WORKDIR /var/www/html
RUN curl -o /tmp/YOURLS-$YOURLS_VERSION.tar.gz -L https://github.com/YOURLS/YOURLS/archive/$YOURLS_VERSION.tar.gz && \
    tar -zxf /tmp/YOURLS-$YOURLS_VERSION.tar.gz --strip-components=1 && \
    rm /tmp/YOURLS-$YOURLS_VERSION.tar.gz && \
    docker-php-ext-install pdo_mysql && \
    a2enmod rewrite && \
    rm *.html *.md *.txt

COPY htaccess .htaccess
COPY index.php ./index.php
COPY config.php ./user/config.php
