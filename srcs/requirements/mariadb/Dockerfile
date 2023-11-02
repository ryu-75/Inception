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

RUN		rm -rf /etc/mysql/my.cnf

# Copie les fichiers de configuration de MariaDB
COPY    conf/mariadb-server.conf /etc/mysql/my.cnf
COPY	conf/script.sh /script.sh

# Creation du dossier sql
RUN		mkdir /run/mysqld && \
		chmod +x /run/mysqld && \
		chmod a+x /script.sh

RUN		mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

# Lancement des configurations des scripts MariaDB entant que point d'entree
CMD ["sh", "/script.sh" ]
