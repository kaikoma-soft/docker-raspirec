#!/bin/sh
set -x

echo
echo "##### install raspirec #####"
echo 

INSTDIR="${RASPIRECDIR:=/usr/local/raspirec}"
NAME="raspirec-master"

test -d $INSTDIR || mkdir -p $INSTDIR
if cd $INSTDIR
then
    SRC="${SRC:=$TMP_DIR/$NAME.zip}"
    unzip  $SRC
    mv ${NAME}/* .
    rmdir ${NAME}
fi

