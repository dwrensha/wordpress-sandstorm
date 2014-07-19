#! /bin/sh
STATICDIR=/var/www
TMPDIR=/var/www_`date +%s%N`
URL=http://127.0.0.1:10000/

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


mv $STATICDIR ${STATICDIR}_tmp
mv $TMPDIR $STATICDIR
rm -rf ${STATICDIR}_tmp
