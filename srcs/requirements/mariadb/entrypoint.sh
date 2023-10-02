#!/bin/sh

set -euo pipefail

# Generate SSL certificate and key
openssl req -x509 -nodes -newkey rsa:4096 \
        -keyout /etc/ssl/private/selfsigned-ssl.key \
        -out /etc/ssl/certs/selfsigned-ssl.crt \
        -days 365 -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=nlorion.42.fr"

# # Check Nginx configuration
# nginx -t

# Start Nginx
nginx -g "daemon off;"
