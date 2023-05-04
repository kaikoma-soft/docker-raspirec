#!/bin/sh

if [ "X$DOCKER" != "Xyes" ]
then
    exit
fi
set -x

apt-get -y remove \
        autoconf \
        cmake \
        gcc \
        g++ 

apt-get -y remove python3 fonts-lato perl python2.7

apt-get -y autoremove
apt-get -y clean

#rm -rf $TMP_DIR
