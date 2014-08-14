#! /bin/sh

echo "getting wordpress..."

wget "https://github.com/dwrensha/WordPress/archive/sandstorm-app.zip"
unzip sandstorm-app.zip
rm sandstorm-app.zip
mv WordPress-sandstorm-app wordpress-read-only
cp wp-config.php wordpress-read-only/

mv wordpress-read-only/wp-content wordpress-read-only/wp-content-read-only

ln -s /var/wordpress/wp-content wordpress-read-only/wp-content

