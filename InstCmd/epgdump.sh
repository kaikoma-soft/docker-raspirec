#!/bin/sh
set -x

echo
echo "#####  install epgdump #####"
echo 

WORKDIR="${TMP_DIR:=/tmp}/epgdump"

mkdir -p $WORKDIR
if cd $WORKDIR
then
    SRC="${SRC:=$TMP_DIR/epgdump-master.zip}"
    unzip -e $SRC
    cd epgdump-master
    cmake .
    make install
    make clean
fi


