#! /bin/sh

echo "getting wordpress..."

wget "https://github.com/dwrensha/WordPress/archive/sandstorm-app.zip"
unzip sandstorm-app.zip
rm sandstorm-app.zip
mv WordPress-sandstorm-app wordpress
cp wp-config.php wordpress/

mv wordpress/wp-content wordpress/wp-content-read-only

ln -s /var/wordpress/wp-content wordpress/wp-content

