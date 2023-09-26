LOGIN			= nlorion
DATA_PATH		= /home/${LOGIN}/data
ENV				= LOGIN=${LOGIN} DATA_PATH=${DATA_PATH} DOMAIN=${LOGIN}.42.fr

all				: up

up				:	setup
					sudo ${ENV} docker compose -f srcs/docker-compose.yml up -d --build

setup			:
					sudo mkdir /home/${LOGIN}
					sudo mkdir ${DATA_PATH}
					sudo mkdir ${DATA_PATH}/wordpress-data
					sudo mkdir ${DATA_PATH}/mariadb-data

stop			:
					sudo ${ENV} docker compose -f srcs/docker-compose.yml stop

down			:
					sudo ${ENV} docker compose -f ./srcs/docker-compose.yml down

start			:
					sudo ${ENV} docker compose -f srcs/docker-compose.yml start

delete			:
					sudo docker system prune --volumes --all

clear			: delete
					sudo rm -rf ${DATA_PATH}

fclear			: clear
					sudo rm -rf /home/nlorion

.PHONY			: all setup up start down delete stop clear fclear
