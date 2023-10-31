FROM    alpine:3.17

#NGINX
RUN     apk update && apk upgrade &&\
        apk add --no-cache \
        nginx \
        openssl \
        curl

RUN     mkdir -p /etc/nginx/ssl

# OPENSSL
# Generate SSL certificate and key
RUN     openssl req -x509 -nodes -newkey rsa:4096 \
        -keyout /etc/nginx/ssl/inception-ssl.key \
        -out /etc/nginx/ssl/inception-ssl.crt \
        -sha256 -days 365 -subj "/C=FR/ST=IDF/L=Paris/O=42Network/OU=42Paris/CN=nlorion.42.fr" && \
        ln -sf /dev/stdout /var/log/nginx/access.log && \
        ln -sf /dev/stderr /var/log/nginx/error.log

RUN     mkdir -p /var/run/nginx

# Sauvegarder une copie de la configuration nginx
COPY    conf/default.conf /etc/nginx/nginx.conf
RUN     chmod +x /etc/nginx/nginx.conf

EXPOSE  443/tcp

STOPSIGNAL SIGQUIT

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
