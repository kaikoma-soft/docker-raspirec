#!/bin/sh

if [ "X$DEBUG" = "Xyes" ]
then
    set -x
fi

if [ "$ARIBLIB" != "libaribb25" ]
then
    exit
fi

echo
echo "##### install libaribb25 #####"
echo 

WORKDIR="${TMP_DIR}/libaribb25"

mkdir -p $WORKDIR
if cd $WORKDIR
then
    SRC="${SRC_DIR}/Download/libaribb25-master.zip"
    unzip -e $SRC
    if cd libaribb25-master
    then
        if [ "$USE_YAKISOBA" = "yes" ]
        then
            SRC="$SRC_DIR/InstCmd/patch/libaribb25.patch"
            if patch -u -p1 < $SRC
            then
                echo "patch 成功"
            else
                echo
                echo "+++++++++++++  patch 失敗  ++++++++++++++++"
                echo
            fi
        fi
        
        cmake -B build
        cd build
        make
        make install
        make clean
    else
        echo "error"
    fi
fi

