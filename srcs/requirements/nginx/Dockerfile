FROM  alpine:3.17

WORKDIR /srcs/requirements/nginx

RUN apk update && apk upgrade \
        && apk add nginx \
        && mkdir -p /var/etc/www

COPY ./conf/nginx.conf /etc/nginx/conf/nginx.conf
# COPY ./var/html/www/index.html /usr/share/nginx/html/index.html
# COPY docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]

EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off"]