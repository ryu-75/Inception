#!/bin/sh

set -euo pipefail

WP_VERSION="wordpress-6.3.1.tar.gz"
WP_CHECKSUM="66645126a250591d07946d98f5c9a675"
WP_PATH="/var/www/html/"

if [ $(ls $WP_PATH | wc -l) -eq 0 ]
then
    # Install Wordpress
    wget https://wordpress.org/$WP_VERSION.tar.gz
    test "$WP_CHECKSUM" = "$(md5sum -b $WP_VERSION.tar.gz | cut -d ' ' -f 1)"
    tar -xzvf $WP_VERSION.tar.gz -C $WP_PATH --strip-components=1
    rm $WP_VERSION.tar.gz

    # Install WP Config CLI
    apk update && apk add --no-cache php81-phar php81-mbstring
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    # TODO checksum
    cd tmp && ls -l * && cd /
    # Import Static page
    mv /tmp/src/* /$WP_PATH
fi

# Start PHP
exec /usr/sbin/php-fpm81 --nodaemonize
