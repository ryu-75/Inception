#!/bin/sh

set -euo pipefail

# P_SQL=srcs/requirements/mariadb/conf

echo "[ MySQL ] Configuring MariaDB"
# if [ -d "/var/lib/mysql" ] ;
# then
#   echo "[i] MySQL directory already present, skipping creation";
# else
#   echo "[i] MySQL data directory not found, creating initial DBs";
#   echo "[i] MySQL data directory is created now";
if [ -d "/database.sql" ] ;
then
  echo "[i] Database is already exist";
else
  touch /database.sql;
fi
echo
echo "[ MySQL ] Configuring database"
echo
# mysql -u root -e \
echo "CREATE DATABASE IF NOT EXISTS $DB_DATABASE;" > /database.sql
echo "USE $DB_DATABASE;" >> /database.sql
echo "FLUSH PRIVILEGES;" >> /database.sql
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_PASS';" >> /database.sql
echo "ALTER USER 'root'@'%' IDENTIFIED BY '$DB_PASS';"
echo "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '$DB_PASS';" >> /database.sql
echo "GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%';" >> /database.sql
echo "FLUSH PRIVILEGES;" >> /database.sql
echo
# /database.sql > /database_copy.sql
mysqld --user=root --bootstrap < database.sql
# rm -f database_copy.sql && rm -f database.sql
exec mysqld --user=root $@
# mysql -u root -e "ALTER USER '$DB_ROOT_USER'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS'"
# mysqladmin -u root -p$DB_ROOT_PASS shutdown
echo
echo "[ MySQL ] Configuration done"
