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
    rm -f ${NAME}/.gitignore
    rmdir --ignore-fail-on-non-empty ${NAME}
fi

