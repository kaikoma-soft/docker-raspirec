#!/bin/sh

if [ "X$DEBUG" = "Xyes" ]
then
    set -x
fi

if [ "$ARIBLIB" != "libarib25" ]
then
    exit
fi

echo
echo "##### install libarib25 #####"
echo 

WORKDIR="${TMP_DIR}/libarib25"

mkdir -p $WORKDIR
if cd $WORKDIR
then
    SRC="${SRC_DIR}/Download/libarib25-master.zip"
    unzip -e $SRC
    if cd libarib25-*
    then
        if [ "$USE_YAKISOBA" = "yes" ]
        then
            SRC="$SRC_DIR/InstCmd/patch/libarib25.patch"
            echo
            echo "yakisoba patch "
            echo
            if patch -u -p1 < $SRC
            then
                echo "patch 成功"
            else
                echo "patch 失敗"
            fi
        fi


        cmake .
        make
        make install
        make clean
    else
        exit -1
    fi
fi

