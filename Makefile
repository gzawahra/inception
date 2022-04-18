include srcs/.env 

NAME		=	inception

COMPOSE		=	cd srcs && docker-compose -p $(NAME)

RM			=	rm -rf

SUDO		=	sudo

MAKE_DIR	=	$(SUDO) mkdir -m 777 -p

CHMOD		=	$(SUDO) chmod -R 777

CHOWN		=	$(SUDO) chown -R gz

all:	fclean .up

.up:
	$(MAKE_DIR) $(WP_HOST_VOLUME_PATH)
	$(MAKE_DIR) $(MARIADB_HOST_VOLUME_PATH)
	$(MAKE_DIR) $(CERTS_VOLUME_PATH)
	$(CHOWN) $(DATA_VOLUME_PATH)
	$(CHMOD) $(DATA_VOLUME_PATH)
	$(SUDO)	docker network inspect inception_network >/dev/null 2>&1 || \
   	 docker network create inception_network
	$(COMPOSE) up -d --build

clean:
	$(COMPOSE) stop
	docker system prune --volumes --force --all
	docker image prune --all --force

fclean:	clean
	$(COMPOSE) down -v

re:		prune all

prune:	fclean
	if $(SUDO) $(RM) $(DATA_VOLUME_PATH); then echo "No data folder to remove"; fi

.PHONY: all build .up clean fclean re prune