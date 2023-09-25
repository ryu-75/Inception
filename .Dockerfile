FROM	alpine:3.17

#Installation WP-Cli
RUN		apk add curl && \
		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/bin/wp-cli.phar
		# wordpress --info

# Installation des dependances de PHP 8.1 & MariaDB-client
RUN		apk update && apk upgrade && \
		apk add php81 php81-calendar php81-cgi php81-common php81-type php81-curl \
				php81-dba php81-dev php81-doc php81-dom php81-embed php81-enchant php81-exif \
				php81-ffi php81-fileinfo php81-fpm php81-ftp php81-gd php81-gettext php81-gmp \
				php81-iconv php81-imap php81-intl php81-ldap php81-litespeed php81-mbstring \
				php81-mysqli php81mysqlnd php81-openssl php81-pcntl php81-pdo \
				php81-pdo_dblib php81-pdo_mysql php81-odbc php81-pdo_pgsql php81-pdo_sqlite \
				php81-pear php81-pgsql php81-phar php81-phpdbg php81-posix php81-pspell php81-session \
				php81-shmop php81-sockets php-sodium php81-sqlite3 php81-sysvmsg php81-sysvsem php81-tokenizer \
				php81-xml php81-xmlreader php81-xmlwriter php81-xsl php81-zip php81-simplexml php81-snmp php81-soap && \
		apk add mariadb-client

# Configure PHP-fpm pour ecouter sur le port reseau de creation interne 9000
RUN		sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php81/php-fpm.d/www.conf

# Copie du fichier de configuration Wordpress
COPY 	./tool/configure-wordpress.sh /tmp/configure-wordpress.sh
RUN		chmod +x /tmp/configure-wordpress.sh

WORKDIR	/var/www/html/wordpress

# Lance le fichier de configuration Wordpress au demarrage du conteneur
ENTRYPOINT [ "sh", "/tmp/configure-wordpress.sh" ]
