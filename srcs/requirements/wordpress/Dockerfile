FROM	alpine:3.17

# Installation des dependances de PHP 8.1 & MariaDB-client
RUN		apk update && apk upgrade && \
		apk add --no-cache \
				wget \
				curl \
				bash \
				mariadb-client \
				php81 php81-fpm \
				php81-phar \
				php81-mbstring \
				php81-common \
				php-mysqli \
				argon2-libs \
				libedit \
				libxml2 \
				musl \
				pcre2 \
				zlib && \
				wget https://wordpress.org/wordpress-6.3.1.tar.gz -P /var/www/html && \
				cd /var/www/html && \
				tar -xzvf wordpress-6.3.1.tar.gz && \
				rm wordpress-6.3.1.tar.gz

# Configure PHP-fpm pour ecouter sur le port reseau de creation interne 9000
COPY		/conf/www.conf /etc/php81/fpm/pool.d/
COPY 		/src/wp-config.php /var/www/html/wordpress/wp-config.php

# Copie du fichier de configuration Wordpress
COPY	/tool/configure-wordpress.sh /configure-wordpress.sh
RUN		chmod a+x /configure-wordpress.sh

EXPOSE	9000

# Lance le fichier de configuration Wordpress au demarrage du conteneur
ENTRYPOINT [ "/configure-wordpress.sh" ]

CMD ["/usr/sbin/php-fpm81", "--nodaemonize"]
