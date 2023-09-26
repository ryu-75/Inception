FROM	alpine:3.17

# Installation de MariaDB
RUN     apk update && apk upgrade &&\
		apk add mariadb mariadb-client

# Copie les fichiers de configuration de MariaDB
COPY    ./tool/mariadb-config.sh /tmp/mariadb-config.sh
RUN		chmod +x /tmp/mariadb-config.sh

COPY    ./conf/mariadb.conf /etc/mysql/mariadb.conf


EXPOSE  3306

# Lancement des configurations des scripts MariaDB entant que point d'entree
ENTRYPOINT [ "sh", "/tmp/mariadb-config.sh" ]
