echo "HELLO WORLD"

mkdir -p /var/lib/nginx
mkdir -p /var/log/nginx
mkdir -p /var/run
mkdir -p /var/wordpress/wp-content

cp -r /wordpress/wp-content-read-only/* /var/wordpress/wp-content

bash continue.bash

