#!/bin/sh
#
#  リポジトリを日本サーバーに変更
#

if [ "X$APPROX" != "X" ]
then
    echo
    echo "----- use APPROX -----"
    echo
    sed -i.bak -e "s%http://[^ ]\+%http://${APPROX}:9999/ubuntu/%g" /etc/apt/sources.list 
else
    sed -i.bak -e "s%http://[^ ]\+%http://jp.archive.ubuntu.com/ubuntu/%g" /etc/apt/sources.list 
fi

grep '^deb ' /etc/apt/sources.list 

sleep 1
