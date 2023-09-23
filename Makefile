# PATH		= /home/nlorion/
LOGIN		= nlorion
COMPOSE		= ./srcs/docker-compose.yml
IMAGES		= ./srcs/requirements
APP_NAME	= inception

<<<<<<< HEAD
start		:
				docker-compose -f $(COMPOSE) start
stop		:
				docker-compose -f $(COMPOSE) stop
=======
setup		:
				sudo mkdir -p /home/${LOGIN}/
				sudo mkdir -p /home/${LOGIN}/mariadb/
				sudo mkdir -p /home/${LOGIN}/wordpress/
>>>>>>> df71c35ef31941057e185c3778074d3594b7e405

up		:	setup
			sudo docker-compose up ${COMPOSE} 

<<<<<<< HEAD
clean		: stop

.PHONY		= all start stop clean
=======
build		:
				sudo docker build ${IMAGES}/nginx

# DOMAINE		= nlorion.42.fr

all			: up

clean		:
				sudo rm -rf /home/${LOGIN}

.PHONY		: all build clean start setup
>>>>>>> df71c35ef31941057e185c3778074d3594b7e405
