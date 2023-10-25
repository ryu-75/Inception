#!/bin/sh

set -euo pipefail

echo "[ MySQL ] Configuring MariaDB"
if [ -d "/var/lib/mysql/mysql" ]
then
  echo "[i] MySQL directory already present, skipping creation"
else
  echo "[i] MySQL data directory not found, creating initial DBs"
  echo "[i] MySQL data directory is created now"

  echo "[ MySQL ] Configuring database"
  mysql -u root -e " \
    CREATE DATABASE $DB_DATABASE; \
    CREATE USER '$DB_USER'@'%' IDENTIFIED BY PASSWORD '$DB_PASS'; \
    GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS'; \
    FLUSH PRIVILEGES"
  mysql -u root -e "ALTER USER '$DB_ROOT_USER'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS'"
  mysqladmin -u root -p$DB_ROOT_PASS shutdown
fi
echo
echo "[ MySQL ] Configuration done"