PATH		= ./home/nlorion/data
COMPOSE		= ./srcs/docker-compose.yml
# DOMAINE		= nlorion.42.fr

folder		:
				mkdir -p ${PATH}

wordpress	:
				mkdir -p ${PATH}/wordpress

nginx		:
				mkdir -p ${PATH}/nginx

mariadb		:
				mkdir -p ${PATH}/mariadb

# start		: 
# 				sudo docker-compose -f $(COMPOSE) start
# stop		: 
# 				sudo docker-compose -f $(COMPOSE) stop

all			: folder

clean		:
				sudo rm -rf ${PATH}

.PHONY		= all folder wordpress mariadb nginx start stop clean