#! /bin/sh


mkdir -p /var/lib/nginx
mkdir -p /var/log/nginx
mkdir -p /var/run
mkdir -p /var/wordpress/wp-content

cp -r /wordpress/wp-content-read-only/* /var/wordpress/wp-content

# Link back to the read-only version of the sandstorm plugin, to allow easy updating.
rm -r /var/wordpress/wp-content/plugins/sandstorm
ln -s /wordpress/wp-content-read-only/plugins/sandstorm /var/wordpress/wp-content/plugins/sandstorm

./continue.sh

