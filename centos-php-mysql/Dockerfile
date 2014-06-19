# DOCKER-VERSION 1.0.0

FROM    centos:6.4

MAINTAINER Mike Ebinum, mike@seedtech.io

# Install dependencies for HHVM
# yum update -y >/dev/null && 
RUN yum install -y http://ftp.riken.jp/Linux/fedora/epel/6/i386/epel-release-6-8.noarch.rpm  && curl -L -o /etc/yum.repos.d/hop5.repo "http://www.hop5.in/yum/el6/hop5.repo"

# Install supervisor
RUN yum install -y python-meld3 http://dl.fedoraproject.org/pub/epel/6/i386/supervisor-2.1-8.el6.noarch.rpm

#install nginx, php, mysql, hhvm
RUN ["yum", "-y", "install", "nginx", "php", "php-mysql", "php-devel", "php-gd", "php-pecl-memcache", "php-pspell", "php-snmp", "php-xmlrpc", "php-xml","mysql-server","hhvm", "openssh-server"]

# Create folder for server and add index.php file to for nginx
RUN mkdir -p /var/www/html && chmod a+r /var/www/html && echo "<?php phpinfo(); ?>" > /var/www/html/index.php

#Setup hhvm
#Add config for hhvm
ADD config.hdf /etc/hhvm/config.hdf 

RUN service hhvm restart

RUN echo 'root:vagrant' | chpasswd

#http://stackoverflow.com/questions/18173889/cannot-access-centos-sshd-on-docker
RUN mkdir -p /var/run/sshd ; chmod -rx /var/run/sshd
# http://stackoverflow.com/questions/2419412/ssh-connection-stop-at-debug1-ssh2-msg-kexinit-sent
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
# Bad security, add a user and sudo instead!
RUN sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
# http://stackoverflow.com/questions/18173889/cannot-access-centos-sshd-on-docker
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

# ADD Nginx config
ADD nginx.conf /etc/nginx/conf.d/default.conf

# ADD supervisord config with hhvm setup
ADD supervisord.conf /etc/supervisord.conf

#set to start automatically - supervisord, nginx and mysql
RUN chkconfig supervisord on && chkconfig mysqld on && chkconfig nginx on

ADD scripts/run.sh /run.sh

RUN chmod a+x /run.sh 


EXPOSE 22 80
#Start supervisord (which will start hhvm), nginx, mysql 
#ENTRYPOINT ["/run.sh"]

