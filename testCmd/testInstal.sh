#!/bin/sh

if [ "X$DEBUG" = "Xyes" ]
then
    set -x
fi

#
#  インストールのテストスクリプト
#

#. ./setting.sh

export TMP_DIR=/tmp/raspirec
mkdir -p $TMP_DIR

tar -cf - Download InstCmd testCmd | tar -C $TMP_DIR -xvof -

sh ${TMP_DIR}/InstCmd/all.sh

#sh ${TMP_DIR}/InstCmd/libyakisoba.sh
#sh ${TMP_DIR}/InstCmd/libaribb25.sh
#sh ${TMP_DIR}/InstCmd/recdvb.sh
#sh ${TMP_DIR}/InstCmd/recpt1.sh

exit

for name in libyakisoba.sh \
                libarib25.sh \
                libaribb25.sh \
                recdvb.sh \
                recpt1.sh \
                epgdump.sh \
                raspirec.sh \
                tspacketchk.sh
do
    echo -n "exec $name (y/n)"
    read ans
    if [ "$ans" = "y" ]
    then
        sh "${TMP_DIR}/InstCmd/${name}"
    else
        echo "pass $name"
    fi
done

