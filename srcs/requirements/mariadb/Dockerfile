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
COPY    ./conf/mariadb-server.cnf /etc/mysql/my.cnf.d

# Importation du script d'initialisation
COPY    ./tool/mariadb-config.sh entrypoint.sh /tmp/
RUN		chmod +x  /tmp/entrypoint.sh

EXPOSE	3306

# Lancement des configurations des scripts MariaDB entant que point d'entree
ENTRYPOINT [ "/tmp/entrypoint.sh" ]
