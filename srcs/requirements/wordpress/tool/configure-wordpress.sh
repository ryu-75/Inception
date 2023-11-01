#!/bin/bash

set -euo pipefail

echo "========================================"
echo "          Installing Wordpress          "
echo "========================================"
echo

chmod -R 755 /var/www/html/*

mkdir -p /run/php/
touch /run/php/php81-fpm.pid

echo "Wait database...  "
sleep 10

echo "Creating database configuration file..."
echo "Installing wordpress core..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
cd /var/www/html/wordpress
# wp core download
if [ ! -f /var/www/html/wordpress/wp-config.php ];
then
    echo "Creating wp-config.php"
    wp config create \
                --allow-root \
                --dbname=$DB_DATABASE \
                --dbuser=$DB_USER \
                --dbpass=$DB_PASS \
                --dbhost=$DB_HOST:3306 \
                --dbprefix=wp_ \
                --path=/var/www/html/wordpress \
                --skip-check \
                --force
fi
if [ ! -f /var/www/html/wordpress/admin.php ];
then
    echo "Creating wordpress admin user..."
    wp core install \
                --allow-root \
                --url=$NGINX_HOST \
                --title=$WP_TITLE \
                --admin_user=$WP_ADMIN_NAME \
                --admin_email=$WP_ADMIN_MAIL \
                --admin_password=$WP_ADMIN_PASS \
                --path=/var/www/html/wordpress \
                --skip-email
else
    echo "admin user already exist"
fi
if [ ! -f /var/www/html/wordpress/user.php ];
then
    echo "Creating wordpress default user..."
    wp user create  \
                --allow-root \
                --display_name=$WP_USER_NAME \
                --user_pass=$WP_USER_PASS \
                --role=author $WP_USER_NAME $WP_USER_MAIL \
                --path=/var/www/html/wordpress \
                --porcelain
else
    echo "default user already exist"
fi
# echo "Installing wordpress theme..."
# wp theme install twentyseventeen \
#             --activate \
#             --path=/var/www/html/wordpress \
#             --allow-root
# wp theme status twentyseventeen \
#             --allow-root

echo
echo "========================================"
echo "      Installation is complete.           "
echo "========================================"
echo
exec "$@"
