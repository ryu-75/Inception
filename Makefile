# PATH		= ./home/nlorion/data
COMPOSE		= ./srcs/docker-compose.yml
IMAGES		= ./srcs/requirements
APP_NAME	= inception

build		:
				sudo docker build ${IMAGES}/nginx

# DOMAINE		= nlorion.42.fr

# CREATE FOLDERS
# folder		:
# 				mkdir -p ${PATH}

# wordpress	:
# 				mkdir -p ${PATH}/wordpress

# nginx		:
# 				mkdir -p ${PATH}/nginx

# mariadb		:
# 				mkdir -p ${PATH}/mariadb

# start		: 
# 				sudo docker-compose -f $(COMPOSE) start
# stop		: 
# 				sudo docker-compose -f $(COMPOSE) stop

all			: build

clean		:
				sudo docker stop nginx
				sudo rm -r ${IMAGES}/nginx/log && \
				sudo rm -r ${IMAGES}/nginx/www

.PHONY		: all build clean start