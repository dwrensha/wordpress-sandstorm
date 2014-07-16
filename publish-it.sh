#! /bin/sh
STATICDIR=/var/www
TMPDIR=/var/www_`date +%s%N`
URL=http://127.0.0.1:10000/

rm -rf $TMPDIR
wget --mirror -p --html-extension --convert-links -nH -P $TMPDIR $URL

mv $STATICDIR ${STATICDIR}_tmp
mv $TMPDIR $STATICDIR
rm -rf ${STATICDIR}_tmp
