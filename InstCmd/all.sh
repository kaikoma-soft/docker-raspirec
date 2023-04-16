#!/bin/sh

for name in \
    repoChg.sh      \
    pkg_install.sh  \
    libyakisoba.sh  \
    libarib25.sh    \
    libaribb25.sh   \
    recdvb.sh       \
    recpt1.sh       \
    epgdump.sh      \
    raspirec.sh     \
    tspacketchk.sh  \
    pkg_remove.sh
do
    echo
    echo "###################    $name    ######################"
    echo
    sh ${TMP_DIR}/InstCmd/${name} || exit -1
done


if [ -f /etc/os-release ]
then
    echo
    echo "-----------------------"
    cat /etc/os-release
    echo "-----------------------"
    echo
fi

if [ "X$DEBUG" = "Xyes" ]
then
    if [ -f ${TMP_DIR}/testCmd/ldd_chk.rb ]
    then
        echo "######  ldd chk  ######"
        ruby ${TMP_DIR}/testCmd/ldd_chk.rb
        echo
    fi
fi
