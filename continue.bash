
/usr/bin/php-fpm

echo "started php-fpm. status code:" $?

/usr/bin/nginx -g "pid /var/run/nginx.pid;"

echo "started nginx. status code:" $?


sleep infinity

