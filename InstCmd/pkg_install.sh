#!/bin/sh

if [ "X$DEBUG" = "Xyes" ]
then
    set -x
fi

apt-get -y update 
if [ ! "$DEBUG" = "yes" ]
then
    apt-get -y upgrade
fi

if grep Raspbian /etc/os-release > /dev/null
then
    apt-get -y install locales-all
    locale-gen ja_JP.UTF-8
else
    apt-get -y install language-pack-ja
fi
    

apt-get -y install \
    autoconf \
    bash \
    cmake \
    g++ \
    gcc \
    git \
    libpcsclite-dev \
    lsof \
    pcscd \
    ruby \
    ruby-net-ssh \
    ruby-sass \
    ruby-sinatra \
    ruby-slim \
    ruby-sqlite3 \
    ruby-sys-filesystem \
    sqlite3 \
    unzip \
    sudo \
    tzdata \
    pkg-config \
    libtool \
    wget 

if [ "$HLS" = "yes" ]
then
    sleep 1
    apt-get -y install  ffmpeg
fi

