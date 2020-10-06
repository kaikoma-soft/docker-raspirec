#!/bin/sh
set -x

echo
echo "##### install recpt1 #####"
echo 

WORKDIR="${TMP_DIR:=/tmp}/recpt1"

mkdir -p $WORKDIR
if cd $WORKDIR
then
    SRC="${SRC:=$TMP_DIR/recpt1-master.zip}"
    unzip -e $SRC
    cd recpt1-master
    if cd recpt1
    then
        ./autogen.sh
        ./configure --enable-b25
        make
        make install
        make clean
    fi
fi

