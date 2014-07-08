#!/bin/bash
set -e -x
echo "mysql root pwd"
cat /mysql-root-pw.txt
echo "phpmyadmin pwd"
cat /myadmin-db-pw.txt
echo "starting supervisor in foreground"
supervisord -n