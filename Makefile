# PATH		= ./home/nlorion/data
COMPOSE		= ./srcs/docker-compose.yml

start		:
				docker-compose -f $(COMPOSE) start
stop		:
				docker-compose -f $(COMPOSE) stop

all			: start

clean		: stop

.PHONY		= all start stop clean
