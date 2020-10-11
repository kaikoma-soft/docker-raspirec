#!/bin/sh
set -x

apt-get -y update 
#apt-get -y upgrade

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
    wget 

if [ "$HLS" = "yes" ]
then
    sleep 4
    apt-get -y install  ffmpeg
fi

