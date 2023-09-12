FROM  alpine:3.17
WORKDIR /srcs/requirements/nginx
RUN apt-get update && apt-get install -y nginx
COPY ./conf/nginx.conf /etc/nginx/.conf
EXPOSE 443/tcp
CMD ["nginx", "-g", "daemon off"]