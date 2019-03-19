#!/bin/bash
# stop all the services
mysqladmin -p"$MYSQL_PASSWORD" shutdown
service apache2 stop
service ssh stop
