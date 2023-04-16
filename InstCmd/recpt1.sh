#!/bin/sh
set -x

echo
echo "##### install recpt1 #####"
echo 

WORKDIR="${TMP_DIR:=/tmp}/recpt1"

mkdir -p $WORKDIR
if cd $WORKDIR
then
    SRC="${SRC:=$TMP_DIR/Download/recpt1-master.zip}"
    unzip -e $SRC
    cd recpt1-master

    if [ "$ARIBLIB" = "libaribb25" ]
    then
        echo
        echo "patch for libaribb25"
        echo
        SRC="$TMP_DIR/InstCmd/patch/recpt1-libaribb25.patch"
        if patch -u -p1 < $SRC
        then
            echo "patch 成功"
        else
            echo "patch 失敗"
        fi
    fi
    
    if cd recpt1
    then
        ./autogen.sh
        ./configure --enable-b25
        make
        make install
        make clean
    fi
fi

