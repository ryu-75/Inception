#!/bin/bash

set -euo pipefail

echo "************************"
echo "* MariaDB installation *"
echo "************************"
echo
echo "Database initialization"
echo

# Verification du repertoire avant la creation du fichier
if [ ! -d "/var/lib/mysqld/" ]; then
	mkdir -p /var/lib/mysqld
else
	echo "Folder is already exist"
fi

cd /var/lib/mysqld

# Creation du fichier database.sql
touch database.sql
{
	echo "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
	echo "USE ${DB_DATABASE};"
	echo "FLUSH PRIVILEGES;"
	echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASS}';"
	echo "ALTER USER 'root'@'%' IDENTIFIED BY '${DB_PASS}';"
	echo "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"
	echo "GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%';"
	echo "FLUSH PRIVILEGES;"
} > database.sql

#Copie du contenu de database.sql vers database_new.sql
envsubst < database.sql > database_copy.sql
# cp database.sql database_new.sql

cat database_copy.sql

# Exécution de la commande MySQL avec le fichier database_new.sql
mysqld --user=root --bootstrap < database_copy.sql

# rc-service mariadb start
# mysqladmin -u root password toor
# mysql_upgrade --user=root --boostrap < database_copy.sql

# Suppression des fichiers temporaires
rm -f database.sql && rm -f database_copy.sql

# Exécution de mysqld
exec mysqld --user=root $@
