#! /bin/sh

echo "getting wordpress..."

WORDPRESS_BRANCH=sandstorm-app-3.9

wget "https://github.com/dwrensha/WordPress/archive/${WORDPRESS_BRANCH}.zip"
unzip ${WORDPRESS_BRANCH}.zip
rm ${WORDPRESS_BRANCH}.zip
mv WordPress-${WORDPRESS_BRANCH} wordpress-read-only
cp wp-config.php wordpress-read-only/

mv wordpress-read-only/wp-content wordpress-read-only/wp-content-read-only

ln -s /var/wordpress/wp-content wordpress-read-only/wp-content

