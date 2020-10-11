#!/bin/sh
#
#  リポジトリを日本サーバーに変更
#

if grep Ubuntu /etc/os-release > /dev/null
then
    sed -i.bak -e "s%http://[^ ]\+%http://jp.archive.ubuntu.com/ubuntu/%g" /etc/apt/sources.list 
    TARGET="ubuntu"
fi

if grep Raspbian /etc/os-release > /dev/null
then
    sed -i.bak -e "s%http://[^ ]\+%http://ftp.tsukuba.wide.ad.jp/Linux/raspbian/raspbian/%g" /etc/apt/sources.list
fi

if [ "X$APPROX" != "X" -a "X$TARGET" != "X" ]
then
    echo
    echo "----- use APPROX -----"
    echo
    sed -i.bak -e "s%http://[^ ]\+%http://${APPROX}:9999/$TARGET/%g" /etc/apt/sources.list 
fi


grep '^deb ' /etc/apt/sources.list 

sleep 1
