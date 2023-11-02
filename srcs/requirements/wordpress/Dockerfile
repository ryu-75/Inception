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
				gettext \
				musl \
				pcre2 \
				zlib && \
				wget https://wordpress.org/wordpress-6.3.1.tar.gz -P /var/www/html && \
				cd /var/www/html && \
				tar -xzvf wordpress-6.3.1.tar.gz && \
				rm wordpress-6.3.1.tar.gz

# Configure PHP-fpm pour ecouter sur le port reseau de creation interne 9000
RUN			sed -i 's/listen = 127.0.0.1:9000/listen = wordpress:9000/' /etc/php81/php-fpm.d/www.conf

# Copie du fichier de configuration Wordpress
COPY	/tool/configure-wordpress.sh /configure-wordpress.sh
RUN		chmod a+x /configure-wordpress.sh

EXPOSE	9000

# Lance le fichier de configuration Wordpress au demarrage du conteneur
ENTRYPOINT	["/configure-wordpress.sh"]

CMD	["/usr/sbin/php-fpm81", "--nodaemonize", "-F"]
