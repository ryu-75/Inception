PATH		= 	/home/nlorion
LOGIN		= 	nlorion
IMAGES		= 	./srcs/requirements
# DOMAINE		= nlorion.42.fr

setup		:
				sudo mkdir -p /home/${LOGIN}/
				sudo mkdir -p ${PATH}/mariadb/
				sudo mkdir -p ${PATH}/wordpress/

up			:	setup
				docker-compose ./srcs/docker-compose.yml up -d

stop		:
				sudo docker stop nginx

build		:
				sudo docker build ${IMAGES}/nginx

all			:	up

clean		:
				sudo rm -rf ${PATH}/mariadb
				sudo rm -rf ${PATH}/wordpress

fclean		: 	clean
				sudo rm -rf ${PATH}

.PHONY		: 	all setup up build stop clean fclean
