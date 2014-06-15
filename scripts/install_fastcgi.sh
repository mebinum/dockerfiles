#!/usr/bin/env bash
set -e -x
# modified from https://extremeshok.com/1595/centos-6-apache2-httpd-php-fpm-fastcgi-mod_fastcgi/
yum install -y mod_fastcgi 

sed -i 's/FastCgiWrapper On/FastCgiWrapper Off/g' /etc/httpd/conf.d/fastcgi.conf
 
echo -e "<IfModule mod_fastcgi.c>\nDirectoryIndex index.html index.shtml index.cgi index.php\nAddHandler php5-fcgi .php\nAction php5-fcgi /php5-fcgi\nAlias /php5-fcgi /usr/lib/cgi-bin/php5-fcgi\nFastCgiExternalServer /usr/lib/cgi-bin/php5-fcgi -host 127.0.0.1:9000 -pass-header Authorization\n</IfModule>" >> /etc/httpd/conf.d/fastcgi.conf
 
mkdir /usr/lib/cgi-bin/

chown -R apache:apache /var/run/mod_fastcgi

sed -i 's/LoadModule php5_module/\#LoadModule php5_module/g;s/AddHandler/\#AddHandler/g;s/AddType/\#AddType/g;' /etc/httpd/conf.d/php.conf

httpd restart