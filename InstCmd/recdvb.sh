#!/bin/sh
set -x

echo
echo "##### install recdvb #####"
echo 

WORKDIR="${TMP_DIR:=/tmp}/recdvb"

mkdir -p $WORKDIR
if cd $WORKDIR
then
    #SRC="$TMP_DIR/recdvb-1.3.2.tgz"
    #tar xvzf $SRC
    SRC="${SRC:=$TMP_DIR/recdvb-master.zip}"
    unzip -e $SRC
    if cd recdvb-master   #recdvb-1.3.2
    then
        ./autogen.sh
        ./configure --enable-b25
        make
        make install 
    fi
fi

