# PATH		= /home/nlorion/
LOGIN		= nlorion
COMPOSE		= ./srcs/docker-compose.yml
IMAGES		= ./srcs/requirements
APP_NAME	= inception

setup		:
				sudo mkdir -p /home/${LOGIN}/
				sudo mkdir -p /home/${LOGIN}/mariadb/
				sudo mkdir -p /home/${LOGIN}/wordpress/

up		:	setup
			sudo docker-compose up ${COMPOSE} 

build		:
				sudo docker build ${IMAGES}/nginx

# DOMAINE		= nlorion.42.fr

all			: up

clean		:
				sudo rm -rf /home/${LOGIN}

.PHONY		: all build clean start setup