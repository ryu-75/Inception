#!/bin/bash

set -euo pipefail

echo "************************"
echo "* MariaDB installation *"
echo "************************"
echo
echo "Database initialization"
echo

# Verification du repertoire avant la creation du fichier
mkdir -p /var/lib/mysqld
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql/*
cd /var/lib/mysqld

# Creation du fichier database.sql
touch database.sql
{
	echo "USE mysql;"
	echo "FLUSH PRIVILEGES;"
	echo "DELETE FROM mysql.user WHERE User='';"
	echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"
	echo "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE} CHARACTER SET utf8 COLLATE utf8_general_ci;"
	echo "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"
	echo "GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%';"
	echo "FLUSH PRIVILEGES;"
} > database.sql

if [ -f database.sql ];
then
	#Copie du contenu de database.sql vers database_new.sql
	envsubst < database.sql > database_new.sql

	# cp database.sql database_new.sql
	cat database_new.sql

	# Exécution de la commande MySQL avec le fichier database_new.sql
	mysqld --user=root --bootstrap < database_new.sql

	# Suppression des fichiers temporaires
	rm -f database.sql && rm -f database_new.sql
fi
# Exécution de mysqld
mysqld --user=mysql $@