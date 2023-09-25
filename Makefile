all				: up

up				:	setup
					sudo docker compose -f srcs/docker-compose.yml up -d --build

setup			:
					sudo mkdir /home/nlorion
					sudo mkdir /home/nlorion/data
					sudo mkdir /home/nlorion/data/wordpress-data
					sudo mkdir /home/nlorion/data/mariadb-data

stop			:
					sudo docker compose -f srcs/docker-compose.yml stop

start			:
					sudo docker compose -f srcs/docker-compose.yml start

delete			:
					sudo docker system prune --volumes --all

clear			: delete
					sudo rm -rf /home/nlorion/data/

fclear			: clear
					sudo rm -rf /home/nlorion

.PHONY			: all setup up start delete stop clear fclear
