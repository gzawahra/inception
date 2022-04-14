#!/bin/sh
function wait_for_db()
{
	i=1
	while ! mariadb -h$MARIADB_HOST -P${MARIADB_PORT} -u$MARIADB_USER -p$MARIADB_PASSWORD; do
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

while ! mariadb -h$MARIADB_HOST -P${MARIADB_PORT} -u$MARIADB_USER -p$MARIADB_PASSWORD; do echo "waiting for db ..."; done
wp core install --url="gizawahr.42.fr" --title="Wordpress" --admin_user="gizawahr" --admin_password="badpassword" --admin_email="gzawahra@gmail.com" --skip-email
wp plugin install hello-dolly --activate
wp theme install twentytwenty --activate
wp plugin install redis-cache --activate
wp plugin update --all
wait_for_redis && wp redis enable
wp plugin update --all
wp user create testuser test@user.com --role=author --user_pass=userpassword
wp post create --post_title="Wordpress" --post_content="Welcome to wordpress" --post_status=publish --post_author="gizawahr"

php-fpm7 -F -R