#!/bin/sh

set -euo pipefail

echo "[ MySQL ] Configuring MariaDB"

if [ ! -d "/run/mysqld" ]; 
then
  mkdir -p /run/mysqld
  chown -R mysql:mysql /run/mysqld
fi

if [ -d "/var/lib/mysql/mysql" ];
then
  echo "[i] MySQL directory already present, skipping creation"
else
  echo "[i] MySQL data directory not found, creating initial DBs"
  chown -R mysql:mysql /var/lib/mysql/
  mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null
  echo "[i] MySQL data directory is created now"

  echo "[ MySQL ] Configuring database"
  tfile=/tmp/.tfile
  if [ ! -f $tfile ];
  then
      return 1
  fi

  echo "USE mysql;" > $tfile
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';" >> $tfile
  echo "CREATE DATABASE ${WP_DB_NAME};" >> $tfile
  echo "CREATE USER '${WP_DB_USER}'@'%' IDENTIFIED BY PASSWORD '${WP_DB_PASS}';" >> $tfile
  echo "GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${WP_DB_USER}'@'%' IDENTIFIED BY '${WP_DB_PASS}';" >> $tfile
  echo "FLUSH PRIVILEGES;" >> $tfile

  /usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tfile
  rm -f $tfile

  echo "[ MySQL ] Configuration done"
fi

echo "[ MySQL ] database connect to MariaDB"
sed -i "s|.*skip-networking.*|skip-networking|g" /etc/my.cnf
sed -i "s|.*skip-networking.*|skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

echo "[ MySQL ] Starting MariaDB on port 3306"
exec /usr/bin/mysqld/ --user=mysql --console
