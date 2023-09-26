FROM	alpine:3.17

#Installation WP-Cli
RUN		apk add curl && \
		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/bin/wp-cli.phar

# Installation des dependances de PHP 8.1 & MariaDB-client
RUN		apk update && apk upgrade && \
		apk add php81 php81-fpm \
				argon2-libs \
				libedit \
				libxml2 \
				musl \
				pcre2 \
				php81-common \
				zlib && \
		apk add mariadb-client

# Configure PHP-fpm pour ecouter sur le port reseau de creation interne 9000
RUN		sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php81/php-fpm.d/www.conf

# Copie du fichier de configuration Wordpress
COPY 	./tool/configure-wordpress.sh /tmp/configure-wordpress.sh
RUN		chmod +x /tmp/configure-wordpress.sh

WORKDIR	/var/www/html/wordpress

# Lance le fichier de configuration Wordpress au demarrage du conteneur
ENTRYPOINT [ "sh", "/tmp/configure-wordpress.sh" ]
