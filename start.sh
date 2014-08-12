#! /bin/sh


mkdir -p /var/lib/nginx
mkdir -p /var/log/nginx
mkdir -p /var/run
mkdir -p /var/wordpress/wp-content
mkdir -p /var/www

cat > /var/www/index.html <<__EOF__
<html><body>
<p>This WordPress site has been set up successfully, but no content has
been published. Go click the "Regenerate Public Site" button! </p>
</body></html>
__EOF__

cp -r /wordpress/wp-content-read-only/* /var/wordpress/wp-content

./continue.sh

