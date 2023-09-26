#!/bin/bash

clear
echo "========================================"
echo "        Wordpress Install Script        "
echo "========================================"
echo
echo "========================================"
echo "          Database details              "
echo "========================================"
echo

echo -n "Database Host (e.g localhost) : "
read dbhost

echo -n "Database Name : "
read dbname

echo -n "Database User: "
read dbuser

echo -n "Database Password :"
read dbwpass
echo

echo "========================================"
echo "              Admin details             "
echo "========================================"
echo

echo -n "Site url : "
read siteurl

echo -n "Site Name (e.g nlorion) : "
read sitename

echo -n "Email Address : "
read wpemail

echo -n "Admin User Name : "
read wpuser

echo -n "Admin User Password : "
read wppass

echo -n "run install ? (y/n) : "
read run

if [ "$run" == n ] ;
then
    exit
else
    echo "========================================"
    echo "          Installing Wordpress          "
    echo "========================================"

    echo "Waiting for MariaDB..."
    while ! mariadb -h${DB_HOST} -u${WP_DB_USER} -p${WP_DB_PASS} ${WP_DB_NAME} &>/dev/null
    do
        sleep 3
    done
    echo "MariaDB accessible."

    echo "Creating database configuration file..."
    if [ -f ${WP_PATH}/wp-config.php ]
    then
        echo "Wordpress is already configured."
    else
        echo "Installing worpress..."
        echo "Updating WP-CLI..."
        wp-cli.phar cli update --yes --allow-root
        echo "Downloading wordpress..."
        wp-cli.phar core download --allow-root
        echo "Creating wp-config.php..."
        wp-cli.phar config create --dbname=${WP_DB_NAME} --dbuser=${WP_DB_USER} --dbpass=${WP_DB_PASS} --dbhost=${DB_HOST} --path=${WP_PATH} --allow-root
        echo "Installing wordpress core..."
        wp-cli.phar core install --url="${NGINX_HOST}/wordpress" --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASS} --admin_email=${WP_ADMIN_EMAIL} --path=${WP_PATH} --allow-root
        echo "Creating wordpress default user..."
        wp-cli.phar user create ${WP_USER} ${WP_USER_MAIL} --user_pass=${WP_USER_PASS} --role=subscriber --display_name=${WP_USER} --porcelain --path=${WP_PATH} --allow-root
        echo "Installing wordpress theme..."
        wp-cli.phar theme install the-bootstrap-blog --path=${WP_PATH} --activate --allow-root
        wp-cli.phar theme status the-bootstrap-blog --allow-root
    fi

    echo
    echo "Starting wordpress fastCGI on port 9000"
    exec /usr/sbin/php-fpm81 -F -R
fi

echo "========================================"
echo "      Installation is complete.           "
echo "========================================"
echo
