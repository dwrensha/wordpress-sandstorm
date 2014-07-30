#! /bin/sh


mkdir -p /var/lib/nginx
mkdir -p /var/log/nginx
mkdir -p /var/run
mkdir -p /var/wordpress/wp-content
mkdir -p /var/www

cat > /var/www/index.html <<__EOF__
<html><body>
<p>This WordPress site has been set up successfully, but no content has
been published. Go click the "Publish" button! </p>
</body></html>
__EOF__



cp -r /wordpress/wp-content-read-only/* /var/wordpress/wp-content

# Link back to the read-only version of the sandstorm plugin, to allow easy updating.
rm -r /var/wordpress/wp-content/plugins/sandstorm
ln -s /wordpress/wp-content-read-only/plugins/sandstorm /var/wordpress/wp-content/plugins/sandstorm

./continue.sh

