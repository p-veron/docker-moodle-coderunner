#!/bin/bash
if [ ! -f /var/www/html/moodle/config.php ]; then
  echo '127.0.0.1  localhost' > /etc/hosts
  chown -R www-data:www-data /var/moodledata 
  #lancement du serveur mysql
  chown -R mysql:mysql /var/lib/mysql /var/run/mysqld 
  rm -rf /var/lib/mysql/* 
  /usr/sbin/mysqld --initialize-insecure
  /usr/bin/mysqld_safe --skip-grant-tables --skip-networking &
  sleep 5
  mysql -u root -e "FLUSH PRIVILEGES; SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_PASSWORD');"
  mysql -uroot -p$MYSQL_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
  mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE moodle; GRANT ALL PRIVILEGES ON moodle.* TO 'moodle'@'localhost' IDENTIFIED BY '$MOODLE_PASSWORD'; FLUSH PRIVILEGES;"
  mysqladmin -p$MYSQL_PASSWORD shutdown
  sed -e "s/pgsql/mysqli/ 
  s/username/moodle/
  s@///moodle@//localhost/moodle@
  s/password/$MOODLE_PASSWORD/
  s/example.com/$VIRTUAL_HOST/
  s/\/home\/example\/moodledata/\/var\/moodledata/" /var/www/html/moodle/config-dist.php > /var/www/html/moodle/config.php 
  echo "ServerName $VIRTUAL_HOST" >> /etc/apache2/apache2.conf
  chown www-data:www-data /var/www/html/moodle/config.php
fi
# start all the services
if [ -f /var/run/mysqld/mysqld.sock.lock ]; then
  rm -rf /var/run/mysqld/*
fi
if [ -f /var/run/apache2/apache2.pid ]; then
  rm -rf /var/run/apache2/apache2.pid
fi
echo mysql root password: $MYSQL_PASSWORD
echo moodle admin login: admin
echo moodle admin password: $MOODLE_PASSWORD
echo moodle user login : testeur
echo moodle user password : ';Testeur1;'
echo ssh root password: $SSH_PASSWORD
service ssh start
service apache2 start
service mysql start
