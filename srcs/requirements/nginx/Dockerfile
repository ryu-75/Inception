FROM    alpine:3.17

#NGINX
RUN     apk update && apk upgrade && apk add nginx

RUN     adduser -D -g 'www' www &&\
        mkdir -p /var/www/html/ &&\
        chown -R www:www /run/nginx/ &&\
        chown -R www:www /var/www/html/

COPY    ./conf/nginx.conf /etc/nginx/conf/nginx.conf

#OPENSSL
RUN     apk add openssl && \
        openssl req -x509 -newkey rsa:4096 -keyout \
        /etc/ssl/private/nginx-selfsigned.key -out \
        /etc/ssl/certs/nginx-selfsigned.crt -sha256 -days 365 \
        -nodes -subj "/C=FR/ST=IDF/L=Paris/O=42Network/OU=42Paris/CN=nginx_host_example"

EXPOSE  443/tcp

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off"]
