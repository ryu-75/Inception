FROM	alpine:3.17

# Installation des dependances de PHP 8.1 & MariaDB-client
RUN		apk update && apk upgrade && \
		apk add --no-cache \
				wget \
				curl \
				mariadb-client \
				php81 php81-fpm \
				php-mysqli \
				argon2-libs \
				libedit \
				libxml2 \
				musl \
				pcre2 \
				php81-common \
				zlib

# Configure PHP-fpm pour ecouter sur le port reseau de creation interne 9000
COPY		conf/www.conf ./etc/php81/php-fpm.d/
COPY 		./src/wp-config.php ./var/www/html/wordpress

# Copie du fichier de configuration Wordpress
COPY	./tool/configure-wordpress.sh ./tmp/
# RUN		chmod +x ./tmp/entrypoint.sh
RUN		chmod +x ./tmp/configure-wordpress.sh

COPY	./src/* ./tmp/src/.

EXPOSE	9000

# Lance le fichier de configuration Wordpress au demarrage du conteneur
ENTRYPOINT [ "tmp/entrypoint.sh" ]