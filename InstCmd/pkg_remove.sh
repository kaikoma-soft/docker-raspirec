#!/bin/sh
set -x

apt-get -y remove \
        autoconf \
        cmake \
        gcc \
        g++ 

apt-get -y remove python3 fonts-lato perl

apt-get -y autoremove
apt-get -y clean

#rm -rf $TMP_DIR
