#!/bin/sh
set -x

echo
echo "#####  install tspacketchk #####"
echo 

WORKDIR="${TMP_DIR:=/tmp}/tspacketchk"
NAME="tspacketchk-main"

mkdir -p $WORKDIR
if cd $WORKDIR
then
    SRC="${SRC:=$TMP_DIR/$NAME.zip}"
    unzip $SRC
    cd $NAME
    make
    make install
    make clean
fi


