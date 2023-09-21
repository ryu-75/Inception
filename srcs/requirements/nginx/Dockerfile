FROM  alpine:3.17

WORKDIR /requirements/nginx

RUN apk update && apk upgrade \
        && apk add nginx \
        && mkdir -p /var/www/html

COPY ./conf/nginx.conf /etc/nginx/conf/nginx.conf

# RUN vi /var/www/html/index.html \
#         && echo "<h1>Bonjour tout le monde !</h1>" > /var/www/index.html;

RUN apk run curl \
        && curl localhost


# RUN adduser -D -g 'www' www \
#         && chown -R www:www /var/www/html \
#         && chown -R www:www www

ENTRYPOINT ["nginx"]

EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off"]