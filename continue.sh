#! /bin/sh

/usr/sbin/php5-fpm --fpm-config /etc/php/php-fpm.conf -c /etc/php/php.ini
echo "started php-fpm. status code:" $?

CGICONF=/var/fastcgi.conf
rm -f $CGICONF;
fastcgi_param () {
  echo "fastcgi_param $1 `base64 /dev/urandom | head -c 60`;" >> $CGICONF
}

fastcgi_param WORDPRESS_AUTH_KEY;
fastcgi_param WORDPRESS_SECURE_AUTH_KEY;
fastcgi_param WORDPRESS_LOGGED_IN_KEY;
fastcgi_param WORDPRESS_NONCE_KEY;
fastcgi_param WORDPRESS_AUTH_SALT;
fastcgi_param WORDPRESS_SECURE_AUTH_SALT;
fastcgi_param WORDPRESS_LOGGED_IN_SALT;
fastcgi_param WORDPRESS_NONCE_SALT;


/usr/sbin/nginx -g "pid /var/run/nginx.pid;"
echo "started nginx. status code:" $?


sleep infinity

