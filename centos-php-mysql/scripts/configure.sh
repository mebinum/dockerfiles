#!/bin/bash

#configure ssh
mkdir /var/run/sshd
mkdir -p /root/.ssh
chmod 700 /root/.ssh
mv /src/authorized_keys /root/.ssh/.
chmod 600 /root/.ssh/*
chown -Rf root:root /root/.ssh

# configure supervisor
mkdir -p /var/log/supervisor

# configure sshd to block authentication via password
sed -i.bak 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
rm /etc/ssh/sshd_config.bak

# https://github.com/tacahilo/centos-with-docker/blob/master/vagrant.sh
# #!/bin/sh
# set -e

# install -v -o vagrant -g vagrant -m 0700 -d /home/vagrant/.ssh
# curl -o /home/vagrant/.ssh/authorized_keys -kL 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
# chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
# chmod 600 /home/vagrant/.ssh/authorized_keys

# cat <<'EOF' > /home/vagrant/.bash_profile
# [ -f ~/.bashrc ] && . ~/.bashrc
# export PATH=$PATH:/sbin:/usr/sbin:$HOME/bin
# EOF