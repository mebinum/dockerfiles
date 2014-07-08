#!/bin/bash
set -e -x
#Modified from https://github.com/ricardoamaro/docker-drupal/blob/master/start.sh
#and https://gist.github.com/benschw/7391723

if [ ! -f /var/lib/mysql/ibdata1 ]; then
	# Start mysql
	mysql_install_db
 
	/usr/bin/mysqld_safe &
	sleep 10s

	# Generate random passwords 
	MYADMIN_DB="phpmyadmin"
	MYSQL_PASSWORD=`pwgen -c -n -1 12`
	MYADMIN_PASSWORD=`pwgen -c -n -1 12`

	# This is so the passwords show up in logs. 
	echo mysql root password: $MYSQL_PASSWORD
	echo phpmyadmin password: $MYADMIN_PASSWORD
	echo $MYSQL_PASSWORD > /mysql-root-pw.txt
	echo $MYADMIN_PASSWORD > /myadmin-db-pw.txt
	mysqladmin -u root password $MYSQL_PASSWORD 
	mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE phpmyadmin; GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'phpmyadmin'@'localhost' IDENTIFIED BY '$MYADMIN_PASSWORD'; FLUSH PRIVILEGES;"

	killall mysqld
	sleep 10s
fi