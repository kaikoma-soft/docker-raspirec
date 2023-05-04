#!/bin/sh
set -x

echo
echo "#####  install tspacketchk #####"
echo 

WORKDIR="${TMP_DIR}/tspacketchk"
NAME="tspacketchk-main"

mkdir -p $WORKDIR
if cd $WORKDIR
then
    SRC="${SRC_DIR}/Download/$NAME.zip"
    unzip $SRC
    cd $NAME
    make
    make install
    make clean
fi


