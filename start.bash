echo "HELLO WORLD"

mkdir -p /var/lib/nginx
mkdir -p /var/log/nginx
mkdir -p /var/run

/usr/bin/nginx -g "pid /var/run/nginx.pid;"

echo "started nginx. status code:" $?
