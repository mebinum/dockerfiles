# DOCKER-VERSION 1.0.0

FROM    centos:centos6

MAINTAINER Mike Ebinum, mike@seedtech.io

# Install dependencies for HHVM
# yum update -y >/dev/null && 
RUN yum install -y http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm  && curl -L -o /etc/yum.repos.d/hop5.repo "http://www.hop5.in/yum/el6/hop5.repo"

# Install supervisor
RUN yum install -y python-meld3 http://dl.fedoraproject.org/pub/epel/6/i386/supervisor-2.1-8.el6.noarch.rpm

#install nginx, php, mysql, hhvm
RUN ["yum", "-y", "install", "nginx", "php", "php-mysql", "php-devel", "php-gd", "php-pecl-memcache", "php-pspell", "php-snmp", "php-xmlrpc", "php-xml","hhvm"]

# Create folder for server and add index.php file to for nginx
RUN mkdir -p /var/www/html && chmod a+r /var/www/html && echo "<?php phpinfo(); ?>" > /var/www/html/index.php

#Setup hhvm - add config for hhvm
ADD config.hdf /etc/hhvm/config.hdf 

RUN service hhvm restart

# ADD Nginx config
ADD nginx.conf /etc/nginx/conf.d/default.conf

# ADD supervisord config with hhvm setup
ADD supervisord.conf /etc/supervisord.conf

#set to start automatically - supervisord, nginx and mysql
RUN chkconfig supervisord on && chkconfig nginx on

ADD scripts/run.sh /run.sh

RUN chmod a+x /run.sh 


EXPOSE 22 80
#Start supervisord (which will start hhvm), nginx, mysql 
ENTRYPOINT ["/run.sh"]

