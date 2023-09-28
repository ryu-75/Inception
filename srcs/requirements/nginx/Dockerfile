FROM    alpine:3.17

#NGINX
RUN     apk update && apk upgrade
RUN     apk add --no-cache nginx openssl curl

RUN     adduser -D -g 'www' www &&\
        mkdir -p /var/www/html/ &&\
        chown -R www:www /run/nginx/ &&\
        chown -R www:www /var/www/html/

COPY    ./conf/nginx.conf /etc/nginx/conf/nginx.conf
COPY    ./conf/default.conf /etc/nginx/conf.d/default.conf

# OPENSSL
RUN     openssl req -x509 -newkey rsa:4096 -keyout \
        /etc/ssl/private/selfsigned-ssl.key -out \
        /etc/ssl/certs/selfsigned-ssl.crt -sha256 -days 365 \
        -nodes -subj "/C=FR/ST=IDF/L=Paris/O=42Network/OU=42Paris/CN=nlorion.42.fr"

EXPOSE  443/tcp

STOPSIGNAL SIGTERM

RUN     nginx -t

CMD ["nginx", "-g", "daemon off;"]