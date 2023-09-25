FROM	alpine:3.17

RUN     apk add --update mysql mysql-client && rm -f /var/cache/apk/* 

# COPY    ./tool/mariadb-config.sh ./etc/mysql/mariadb-config.sh
# COPY    my.cnf ./etc/mysql/my.cnf

EXPOSE  3306

WORKDIR /etc/mysql/

CMD     ["./tool/mariadb-configuration.sh"]

ENTRYPOINT [ "sh", "./tool/mariadb-configure.sh" ]