#!/bin/bash

set -euo pipefail

echo "========================================"
echo "          Installing Wordpress          "
echo "========================================"
echo
if [ -d "/run/php/" ];
then
    echo "/run/php/ is already exist";
else
    # chown -R www-data:www-data /var/www/html/*
    chmod -R 755 /var/www/html/*

    mkdir -p /run/php/
    touch /run/php/php81-fpm.pid

    # Wait for the database
    sleep 10

    echo "Creating database configuration file..."
    echo "Installing wordpress core..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    cd /var/www/html/wordpress
    wp core install \
                --url=$NGINX_HOST \
                --title=$WP_TITLE \
                --admin_user=$WP_ADMIN_NAME \
                --admin_email=$WP_ADMIN_MAIL \
                --admin_password=$WP_ADMIN_PASS \
                --path=/var/www/html/wordpress \
                --skip-email \
                --allow-root
    echo "Creating wordpress default user..."
    wp user create \
                --user_pass=$WP_USER_PASS \
                --display_name=$WP_USER_NAME \
                --path=/var/www/html/wordpress \
                --role=author $WP_USER_NAME $WP_USER_MAIL\
                --porcelain \
                --allow-root
    echo "Installing wordpress theme..."
    wp theme install twentyseventeen \
                --activate \
                --path=/var/www/html/wordpress \
                --allow-root
    wp theme status twentyseventeen \
                --allow-root
fi

exec "$@"
echo
echo "========================================"
echo "      Installation is complete.           "
echo "========================================"
echo
