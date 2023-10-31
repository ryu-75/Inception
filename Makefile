LOGIN			= 	nlorion
DATA_PATH		= 	/home/${LOGIN}

all				: 	up

up				:	setup
					sudo docker compose -f srcs/docker-compose.yml up --build

setup			:
					sudo mkdir ${DATA_PATH}
					sudo mkdir ${DATA_PATH}/data
					sudo mkdir ${DATA_PATH}/data/wordpress-data
					sudo mkdir ${DATA_PATH}/data/mariadb-data

stop			:
					sudo docker compose -f srcs/docker-compose.yml stop

down			:
					sudo docker compose -f ./srcs/docker-compose.yml down

start			:
					sudo docker compose -f srcs/docker-compose.yml start

prune			:
					sudo docker system prune --volumes --all

clean			: 	stop prune

fclean			: 	clean
					sudo rm -rf ${DATA_PATH}/data/wordpress-data
					sudo rm -rf ${DATA_PATH}/data/mariadb-data
					sudo rm -rf ${DATA_PATH}

re				:	fclean up

.PHONY			: 	all setup up re start restart down delete stop clean fclean
