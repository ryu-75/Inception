LOGIN			= nlorion
DATA_PATH		= /home/${LOGIN}/data

all				: up

up				:	setup
					sudo docker compose -f srcs/docker-compose.yml up -d --build

setup			:
					sudo mkdir /home/${LOGIN}
					sudo mkdir ${DATA_PATH}
					sudo mkdir ${DATA_PATH}/wordpress-data
					sudo mkdir ${DATA_PATH}/mariadb-data

stop			:
					sudo docker compose -f srcs/docker-compose.yml stop

start			:
					sudo docker compose -f srcs/docker-compose.yml start

delete			:
					sudo docker system prune --volumes --all

clear			: delete
					sudo rm -rf ${DATA_PATH}

fclear			: clear
					sudo rm -rf /home/nlorion

.PHONY			: all setup up start delete stop clear fclear
