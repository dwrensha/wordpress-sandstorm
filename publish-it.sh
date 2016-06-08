#! /bin/sh
STATICDIR=/var/www
TMPDIR=/var/www_`date +%s%N`
URL=http://this_will_be_replaced_by_sandstorm:10000
REPLACE_URL=$URL

rm -rf $TMPDIR
wget --mirror -p --convert-links -np -nH -e robots=off -X /wp-admin/ -P $TMPDIR $URL
for q in `find $TMPDIR -name '*\?*'`; do
  if [ -f ${q%\?*} ]; then
     echo 'removing $q';
     rm $q;
  else
    echo 'renaming $q';
    mv $q ${q%\?*};
  fi;
done

# make anying relative that wget failed to clean up
find $TMPDIR -type f -exec sed -i "s|${REPLACE_URL}/|/|g" {} \;
find $TMPDIR -type f -exec sed -i "s|${REPLACE_URL}|/|g" {} \; # URLs without a trailing / need to be changed to point the index

# Make sure to copy over all of the uploads. This is necessary because the current release of wget
# does not yet support srcset in img tags.
cp -r /var/wordpress/wp-content/uploads $TMPDIR/wp-content/

mv $STATICDIR ${STATICDIR}_tmp
mv $TMPDIR $STATICDIR
rm -rf ${STATICDIR}_tmp
