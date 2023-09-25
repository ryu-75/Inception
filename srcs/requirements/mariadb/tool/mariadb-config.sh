#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
  mkdir -p /run/mysqld
fi

if [ -d /app/mysql ]; then
  echo "[i] MySQL directory already present, skipping creation"
else
  echo "[i] MySQL data directory not found, creating initial DBs"

  mysql_install_db --user=root > /dev/null

  if [ "$DB_ROOT_PASS" = "" ]; then
    DB_ROOT_PASS=root
    echo "[i] MySQL root Password: $DB_ROOT_PASS"
  fi

  DB_DATABASE=${DB_DATABASE:-""}
  DB_USER=${DB_USER:-""}
  DB_PASS=${DB_PASS:-""}

  tfile=`mktemp`
  if [ ! -f "$tfile" ]; then
      return 1
  fi

  cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$DB_ROOT_PASS" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
EOF

  if [ "$DB_DATABASE" != "" ]; then
    echo "[i] Creating database: $DB_DATABASE"
    echo "CREATE DATABASE IF NOT EXISTS \`$DB_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

    if [ "$DB_USER" != "" ]; then
      echo "[i] Creating user: $MYSQL_USER with password $DB_PASS"
      echo "GRANT ALL ON \`$DB_DATABASE\`.* to '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';" >> $tfile
    fi
  fi

  /usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tfile
  rm -f $tfile
fi