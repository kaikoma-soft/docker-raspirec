#!/bin/sh
set -x

echo
echo "##### install raspirec #####"
echo 

INSTDIR="${RASPIRECDIR:=/usr/local/raspirec}"

test -d $INSTDIR || mkdir -p $INSTDIR
if cd $INSTDIR
then
    SRC="${SRC:=$TMP_DIR/raspirec-master.zip}"
    unzip -e $SRC
    mv raspirec-master/* .
    rmdir raspirec-master
fi

