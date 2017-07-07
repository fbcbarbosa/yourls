FROM library/php:5.6.30-alpine
MAINTAINER Fernando Barbosa <fbcbarbosa@gmail.com>
ARG NR_INSTALL_KEY 
ARG NR_APP_NAME

# Install New Relic
ENV NR_INSTALL_SILENT true
ENV YOURLS_VERSION 1.7.2

RUN mkdir -p /opt/newrelic
WORKDIR /var/www/html

RUN apk add --no-cache --update \
	apache2 \
        php5-apache2 \
    	py-pip \
        tar \
	wget && \
    cd /opt/newrelic && \
    wget -r -nd --no-parent -Alinux-musl.tar.gz \
    http://download.newrelic.com/php_agent/release/ >/dev/null 2>&1 \
    && tar -xzf newrelic-php*.tar.gz --strip-components=1 && \
    chmod +x newrelic-install && \
    ./newrelic-install install && \
    pip install newrelic-plugin-agent && \
    rm *.tar.gz && \
    mkdir -p /var/log/newrelic && \
    mkdir -p /var/run/newrelic && \
    curl -o /tmp/YOURLS-$YOURLS_VERSION.tar.gz -L https://github.com/YOURLS/YOURLS/archive/$YOURLS_VERSION.tar.gz && \
    tar -zxf /tmp/YOURLS-$YOURLS_VERSION.tar.gz --strip-components=1 && \
    rm /tmp/YOURLS-$YOURLS_VERSION.tar.gz && \
    docker-php-ext-install pdo_mysql && \
    #a2enmod rewrite && \
    rm *.html *.md *.txt && \
    pip uninstall -y pip && \
    apk del \ 
	py-pip \
        wget && \
    rm -rf /var/cache/apk/*

#    sed -i "/^newrelic.appname/c\newrelic.appname = \"$NR_APP_NAME\"" \
#    /usr/local/etc/php/conf.d/newrelic.ini && \

COPY htaccess .htaccess
COPY index.php ./index.php
COPY config.php ./user/config.php
