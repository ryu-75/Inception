# PATH		= ./home/nlorion/data
COMPOSE		= ./srcs/docker-compose.yml

start		: 
				sudo docker-compose -f $(COMPOSE) start
stop		: 
				sudo docker-compose -f $(COMPOSE) stop

all			: start

clean		: stop 

.PHONY		= all start stop clean