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
dbwpass
echo

echo "========================================"
echo "              Admin details             "
echo "========================================"
echo

echo -n "Site url (e.g https://www.nlorion.42.fr/) : "
read siteurl

echo -n "Site Name (e.g nlorion) : "
read sitename

echo -n "Email Address (e.g nlorion@42.paris.fr) : "
read wpemail

echo -n "Admin User Name : "
read wpuser

echo -n "Admin User Password : "
read wppass

echo -n "run install ? (y/n) : "
read run
if [ "$run" == n ] ; then
exit
else
echo "========================================"
echo "          Installing Wordpress          "
echo "========================================"

echo "Downloading wordpress latest version..."
curl -O https://wordpress.org/latest.tar.gz

echo "Extracting tarball wordpress..."
tar -zxvf latest.tar.gz

#copy file to parent dir
cp -rf wordpress/* .

#remove files from wordpress folder
rm -R wordpress
#create wp config
echo
echo "Creating databasse configuration file..."
cp wp-config-sample.php wp-config.php
#set database details with perl find and replace
perl -pi -e "s/localhost/$dbhost/g" wp-config.php
perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
perl -pi -e "s/username_here/$dbuser/g" wp-config.php
perl -pi -e "s/password_here/$dbpass/g" wp-config.php

#create uploads folder and set permissions
mkdir wp-content/uploads
chmod 777 wp-content/uploads
echo
echo "Installing worpress..."
wp core install --url="$siteurl" --title="$sitename" --admin_user="$wpuser" --admin_password="$wppas" --admin_email="$wpemail"
#remove zip file
#rm lastest.tar.gz

#remove bash script
#rm wp-install.sh

echo "========================================"
echo "      Installion is complete.           "
echo "========================================"
echo
fi