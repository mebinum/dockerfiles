# DOCKER-VERSION 1.0.0

FROM    centos:6.4

MAINTAINER Mike Ebinum, mike@seedtech.io

# Add the EPEL repo to the machine
# yum update -y >/dev/null && 
RUN yum install -y http://ftp.riken.jp/Linux/fedora/epel/6/i386/epel-release-6-8.noarch.rpm  && curl -L -o /etc/yum.repos.d/hop5.repo "http://www.hop5.in/yum/el6/hop5.repo"

# Install supervisor
RUN yum install -y python-meld3 http://dl.fedoraproject.org/pub/epel/6/i386/supervisor-2.1-8.el6.noarch.rpm

#install phpmyadmin and mysql-servers
RUN ["yum", "-y", "install", "phpmyadmin","mysql-server","mysql","pwgen"]

# ADD supervisord config
ADD supervisord.conf /etc/supervisord.conf

#add Phpmyadmin configuration
ADD config.inc.php /etc/phpMyAdmin/config.inc.php

#set mysql to connect to all addresses
#RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

#set phpmyadmin to allow requests from local ips only
RUN sed -i -e"s/Require ip 127.0.0.1/Require ip 10 192.168/" -e"s/Allow from 127.0.0.1/Allow from 10 192.168/" /etc/httpd/conf.d/phpMyAdmin.conf

#setup mysql 
ADD scripts/config.sh /config.sh 

RUN chmod a+x /config.sh && /config.sh

ADD scripts/run.sh /run.sh

RUN chmod a+x /run.sh 

EXPOSE  80
#Start supervisord (which will start hhvm), nginx, mysql 
#ENTRYPOINT ["/run.sh"]

