FROM	alpine:3.17

# Installation de MariaDB
RUN     apk update && apk upgrade &&\
		apk add --no-cache \
		mysql \
		mysql-client \
		openssl \
		mariadb \
		mariadb-client \
		openrc &&\
		apk add --upgrade mysql-client

# Copie les fichiers de configuration de MariaDB
COPY    conf/mariadb-server.cnf etc/mysql/my.cnf.d
COPY    tool/mariadb-config.sh /mariadb-config.sh

# Importation du script d'initialisation
RUN     mkdir /var/run/mysqld/ && \
        chmod a+x /mariadb-config.sh

EXPOSE	3306

# Lancement des configurations des scripts MariaDB entant que point d'entree
ENTRYPOINT     [ "/mariadb-config.sh" ]

# CMD ["mysqld", "nginx", "-g", "daemon off;"]
