FROM	alpine:3.17

# Installation de MariaDB
RUN     apk update && apk upgrade && \
		apk add --no-cache \
		mysql \
		mysql-client \
		bash \
		openssl \
		gettext \
		openrc && \
		apk add --upgrade mysql-client

RUN		mysql_install_db --user=root --datadir=/var/lib/mysql

# Copie les fichiers de configuration de MariaDB
COPY    conf/mariadb-server.conf /etc/mysql/my.cnf
COPY	conf/script.sh /script.sh
# COPY	conf/database.sql /database.sql

# Creation du dossier sql
RUN		mkdir /run/mysqld
RUN		chmod a+x /script.sh

EXPOSE 3306

# CMD ["mysqld", "--bind-address=0.0.0.0"]

# Lancement des configurations des scripts MariaDB entant que point d'entree
ENTRYPOINT [ "/script.sh" ]
