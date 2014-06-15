#!/usr/bin/env bash
set -e -x

echo "Creating HHVM config for nginx"

echo "Backup nginx default configs"
if [-a '/etc/nginx/sites-enabled/default'] ; then
	mv /etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/default.bak
fi

if [-a '/etc/nginx/conf.d/default.conf'] ; then
	mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
fi

cat > /etc/nginx/conf.d/default <<EOF 
server {
  listen       80;
  server_name localhost;

  root /var/www/html;
  index index.php index.html index.htm;

  location ~ \.(hh|php)$ {
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME /var/www/html$fastcgi_script_name;
    include fastcgi_params;
  }

  location ~ /\.ht {
       deny  all;
  }
}
EOF


echo "Set up configs for nginx"
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
service nginx restart

echo "Backup nginx default configs"
if [-a '/etc/nginx/sites-enabled/default'] ; then
	mv /etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/default.bak
fi

sed -i 's/Port = 80/Port = 9000/g;s/SourceRoot = \/var\/www\//Type = fastcgi\n   SourceRoot = \/var\/www\//g' /etc/hhvm/server.hdf
