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
    SRC="${SRC:=$TMP_DIR/Download/recdvb-master.zip}"
    unzip -e $SRC
    if cd recdvb-master   #recdvb-1.3.2
    then
        SRC="$TMP_DIR/InstCmd/patch/recdvb-libaribb25.patch"
        if [ "$ARIBLIB" = "libaribb25" ]
        then
            echo
            echo "patch for libaribb25"
            echo
            if patch -u -p1 < $SRC
            then
                echo "patch 成功"
            else
                echo "patch 失敗"
            fi
        fi
        
        ./autogen.sh
        ./configure --enable-b25
        make
        make install 
    fi
fi

