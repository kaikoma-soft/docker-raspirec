#!/bin/sh
set -x

apt-get -y update 
#apt-get -y upgrade

apt-get -y install \
    autoconf \
    bash \
    cmake \
    g++ \
    gcc \
    git \
    language-pack-ja \
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
    sudo \
    tzdata \
    wget 

if [ "$HLS" = "yes" ]
then
    sleep 4
    apt-get -y install  ffmpeg
fi

