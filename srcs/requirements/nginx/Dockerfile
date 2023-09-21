FROM  alpine:3.17

WORKDIR /srcs/requirements/nginx

RUN apk update && apk upgrade \
        && apk add nginx \
        && mkdir -p /var/www/html

COPY ./conf/nginx.conf /etc/nginx/conf/nginx.conf

RUN adduser -D -g 'www' www \
        && chown -R www:www /var/www/html \
        && chown -R www:www /www

ENTRYPOINT ["nginx"]

EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off"]