#!/bin/sh
function wait_for_db()
{
	i=1
	while ! mariadb -h${MARIADB_HOST} -P${MARIADB_PORT} -u${MARIADB_USER} -p${MARIADB_PASSWORD}; do
		if [ $i -ge 60 ]; then
			printf "Failed to connect to mariadb\n"
			exit 1
		fi
		printf "Trying to reach mariadb... ($i/60 sec)\n"
		i=$((i+1))
		sleep 1
	done

	printf "Connection to mariadb established.\n"
}
function wait_for_redis()
{
	i=1;
	while [ "$(redis-cli -p ${REDIS_PORT} -h ${REDIS_HOST} ping 2> /dev/null)" != "PONG" ]; do
		if [ $i -ge 60 ]; then
			printf "redis-server took too much time to start properly!\n"
			exit 1
		fi
		printf "Waiting for redis-server to respond to ping... ($i/60 sec)\n"
		i=$(($i+1))
	done
}

set -e

wait_for_db;
printf "hello, \n"
wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PWD} --admin_email=${WP_ADMIN_EMAIL} --skip-email
wp post create --post_title=${WP_TITLE} --post_content="Welcome to  inception wordpress" --post_status=publish --post_author=${WP_ADMIN_USER}
wp plugin install hello-dolly --activate
wp theme install hestia --activate
wp plugin install redis-cache --activate
wp plugin update --all
wait_for_redis && wp redis enable
wp plugin update --all
wp user create ${WP_USER} ${WP_USER_EMAIL} --role=author --user_pass=${WP_USER_PWD}
wp menu create "Mainmenu"
wp menu item add-custom Mainmenu 42intra https://intra.42.fr --porcelain
wp menu item add-custom Mainmenu login https://gizawahr.42.fr/wp-admin --porcelain
wp menu location assign Mainmenu primary
printf "DONE..... \n"
php-fpm7 -F -R
