#!/bin/bash

set -euo pipefail

echo "========================================"
echo "          Installing Wordpress          "
echo "========================================"
# echo "Waiting for MariaDB..."
# timeout=100
# while ! mariadb -h$DB_HOST -u$DB_USER -p$DB_PASS $DB_DATABASE &>/dev/null;
# do
#     timeout=$((timeout - 1))
#     test "$timeout" = 0 && echo "MariaDB timeout." && exit 1
#     sleep 3
# done

# echo "MariaDB accessible."
WP_PATH = /var/www/html/wordpress

echo "Creating database configuration file..."
if [ -f $WP_PATH/wp-config.php ];
then
    echo "Wordpress is already configured."
else
    echo "Installing worpress..."
    echo "Updating WP-CLI..."
    wp cli update \
                --yes \
                --allow-root

    echo "Downloading wordpress..."
    wp core download \
                --allow-root

    echo "Creating wp-config.php..."
    wp config create \
                --dbname=$DB_NAME \
                --dbuser=$DB_USER \
                --dbpass=$DB_PASS \
                --dbhost=$DB_HOST:3306 \
                --path=$WP_PATH \
                --allow-root

    echo "Installing wordpress core..."
    wp core install \
                --url=$NGINX_HOST \
                --title=$WP_TITLE \
                --admin_user=$WP_ADMIN_NAME \
                --admin_email=$WP_ADMIN_MAIL \
                --admin_password=$WP_ADMIN_PASS \
                --path=$WP_PATH \
                --skip_email \
                --allow-root

    echo "Creating wordpress default user..."
    wp user create \
                --user_pass=$WP_USER_PASS \
                --display_name=$WP_USER \
                --path=$WP_PATH \
                --role=author $WP_USER_NAME $WP_USER_MAIL\
                --porcelain \
                --allow-root

    echo "Installing wordpress theme..."
    wp theme install the-bootstrap-blog \
                --path=$WP_PATH \
                --activate \
                --allow-root

    wp theme status the-bootstrap-blog \
                --allow-root
fi

if [ ! -d /run/php ];
then
    mkdir /run/php;
fi

# touch /home/log.txt | ls -la /var/www/html/* > /home/log.txt

echo "========================================"
echo "      Installation is complete.           "
echo "========================================"
echo
