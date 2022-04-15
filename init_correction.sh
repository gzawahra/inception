#!/bin/zsh
docker stop $(docker ps -qa)
docker rm $(docker ps -qa)
docker rmi -f $(docker images -qa)
docker volume rm $(docker volume ls -q)
docker network rm $(docker network ls -q)
# ENV			MARIADB_USER=$mariadb_user			\
# 			MARIADB_PASSWORD=$mariadb_password	\
# 			MARIADB_DATABASE=$mariadb_database	\
# 			MARIADB_PORT=$mariadb_port			\
# 			MARIADB_HOST=$mariadb_host			\
# 			WP_URL=$domain_name					\
# 			WP_TITLE=$wp_title					\
# 			WP_ADMIN_USER=$wp_admin_user		\
# 			WP_ADMIN_PWD=$wp_admin_pwd			\
# 			WP_ADMIN_EMAIL=$wp_admin_email		\
# 			REDIS_HOST=$redis_host				\
# 			REDIS_PORT=$redis_port
