#!/bin/bash

sed -i "s/port = 3306/port = ${MARIADB_PORT}/g" /etc/my.cnf.d/mariadb-server.cnf

mariadbd &

if ! mysqladmin --wait=30 ping; then
	printf "Runtime config error\n"
	exit 1
fi
mariadb -e "$(eval "echo \"$(cat ../config/runtime_config.sql)\"")"
# allow remote connections IMPORTANT DO NOT REMOVE
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

pkill mariadbd
mariadbd
