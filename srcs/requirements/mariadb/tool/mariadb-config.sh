#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
  mkdir -p /run/mysqld
fi

if [ -d /app/mysql ]; then
  echo "[i] MySQL directory already present, skipping creation"
else
  echo "[i] MySQL data directory not found, creating initial DBs"

  mysql_install_db --user=root --basedir=/etc/mysql --datadir=/etc/mysql/data > /dev/null

  if [ "${DB_ROOT_PASS}" = "" ]; then
    ${DB_ROOT_PASS}=root
    echo "[i] MySQL root Password: ${DB_ROOT_PASS}"
  fi

  DB_DATABASE=${DB_DATABASE:-""}
  DB_USER=${DB_USER:-""}
  DB_PASS=${DB_PASS:-""}

  TMP=/etc/tmp
  if [ ! -f ${TMP} ]; then
      return 1
  fi

  echo "CREATE DATABASE IF NOT EXISTS \`${DB_DATABASE}\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> ${TMP}
  echo "CREATE USER ${DB_USER} IDENTIFIED BY PASSWORD ${DB_PASS};" >> ${TMP}
  echo "USE ${DB_DATABASE};" >> ${TMP};
  echo "FLUSH PRIVILEGES;" >> ${TMP};
  echo "GRANT ALL PRIVILEGES ON ${DB_DATABASE} TO ${DB_USER}.* IDENTIFIED BY "${DB_ROOT_PASS}" WITH GRANT OPTION;" >> ${TMP}
  echo "GRANT ALL PRIVILEGES ON ${DB_DATABASE} TO '${NGIN_HOST}' WITH GRANT OPTION;" >> ${TMP}
  echo "ALTER USER '${NGINX_HOST}' IDENTIFIED BY '${DB_USER}';" >> ${TMP}

  /usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tfile
  rm -f $tfile
fi