#! /bin/sh

/usr/bin/php-fpm

echo "started php-fpm. status code:" $?

/usr/bin/nginx -g "pid /var/run/nginx.pid;"

echo "started nginx. status code:" $?

#./sandstorm/bin/getPublicId
#echo "called getPublicId. status code:" $?

sleep infinity

