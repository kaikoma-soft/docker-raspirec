#!/bin/sh

if [ "X$DEBUG" = "Xyes" ]
then
    set -x
fi

echo
echo "#####  install epgdump #####"
echo 

WORKDIR="${TMP_DIR}/epgdump"

mkdir -p $WORKDIR
if cd $WORKDIR
then
    SRC="${SRC_DIR}/Download/epgdump-master.zip"
    unzip -e $SRC
    cd epgdump-master
    cmake .
    make install
    make clean
fi


