FROM    alpine:3.17

RUN     apk update && apk upgrade && \
                apk add nginx && \
                mkdir -p /var/www/html/

COPY    ./conf/nginx.conf /etc/nginx/conf/nginx.conf

RUN     apk add openssl

# RUN adduser -D -g 'www' www \
#         && chown -R www:www /var/www/html/ \
#         && chown -R www:www www

EXPOSE 443/tcp

ENTRYPOINT ["nginx"]

CMD ["-g", "daemon off"]
