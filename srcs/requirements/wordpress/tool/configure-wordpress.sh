#!/bin/bash

set -euo pipefail

echo "========================================"
echo "          Installing Wordpress          "
echo "========================================"
echo
# chown -R www-data:www-data /var/www/html/*
chmod -R 755 /var/www/html
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
wp core download
wp config create \
            --dbname=$DB_DATABASE \
            --dbuser=$DB_USER \
            --dbpass=$DB_PASS \
            --dbhost=mariadb:3306 \
            --dbprefix=wp_ \
            --path=/var/www/wordpress \
            --allow-root \
            --skip-check \
            --force
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
wp user create $WP_USER_NAME $WP_USER_MAIL \
            --user_pass=$WP_USER_PASS \
            --path=/var/www/html/wordpress \
            --role=author \
            --porcelain \
            --allow-root \
            --display_name=$WP_USER_NAME
echo "Installing wordpress theme..."
wp theme install twentyseventeen \
            --activate \
            --path=/var/www/html/wordpress \
            --allow-root
wp theme status twentyseventeen \
            --allow-root

echo
echo "========================================"
echo "      Installation is complete.           "
echo "========================================"
echo
exec /usr/sbin/php-fpm81 -F
# exec "$@"
