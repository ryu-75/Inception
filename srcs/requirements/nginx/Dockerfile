FROM    alpine:3.17

#NGINX
RUN     apk update && apk upgrade &&\
        apk add --no-cache \
        nginx \
        openssl \
        curl

# Sauvegarder une copie de la configuration nginx
COPY    conf/default.conf /etc/nginx/http.d/default.conf
RUN     chmod +x /etc/nginx/http.d/default.conf
# OPENSSL
# Generate SSL certificate and key
RUN     openssl req -x509 -nodes -newkey rsa:4096 \
        -keyout /etc/ssl/private/selfsigned-ssl.key \
        -out /etc/ssl/certs/selfsigned-ssl.crt \
        -sha256 -days 365 -subj "/C=FR/ST=IDF/L=Paris/O=42Network/OU=42Paris/CN=nlorion.42.fr"

EXPOSE  443/tcp

STOPSIGNAL SIGTERM

# Start nginx
CMD ["nginx", "-g", "daemon off;"]