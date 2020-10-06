#!/bin/sh
set -x

echo
echo "##### install libarib25 #####"
echo 

WORKDIR="${TMP_DIR:=/tmp}/libarib25"

mkdir -p $WORKDIR
if cd $WORKDIR
then
    SRC="${SRC:=$TMP_DIR/libarib25-master.zip}"
    unzip -e $SRC
    cd libarib25-master

    if [ "$SC" = "yes" ]
    then
        echo
        echo "sc patch "
        echo
        SRC="$TMP_DIR/LZVsh4x8"
        if [ -f $SRC ]
        then
            patch -u -p0 < $SRC
        fi
    fi

    cmake .
    make
    make install
    make clean
fi

