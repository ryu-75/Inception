setup			:
					sudo mkdir /home/nlorion
					sudo mkdir /home/nlorion/data
					sudo mkdir /home/nlorion/data/wordpress-data
					sudo mkdir /home/nlorion/data/mariadb-data

up				:	setup
					docker-compose -f ./srcs/docker-compose.yml up -d --build

all				: up

stop			:
					docker-compose -f ./srcs/docker-compose.yml stop

start			:
					docker-compose -f ./srcs/docker-compose.yml start

clear			:
					sudo rm -rf /home/nlorion/data/

fclear			: clear
					sudo rm -rf /home/nlorion

.PHONY			: all setup up start stop clear fclear
