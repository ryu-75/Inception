FROM	alpine:3.17

WORKDIR /app

RUN     apk add --update mysql mysql-client && rm -f /var/cache/apk/* 

COPY    ./tool/mariadb-config.sh ./mariadb-config.sh
COPY    ./conf/mariadb.conf ./etc/mysql/mariadb.conf

EXPOSE  3306

CMD     ["./tool/mariadb-configuration.sh"]

ENTRYPOINT [ "sh", "/mariadb-configure.sh" ]