#!/bin/sh

VERSION="1.3.0"

#
# HOST側のデータディレクトリ
#
export DDIR_H="$HOME/docker-raspirec"

#
# Docker側のデータディレクトリ
#
export DDIR_D="/raspirec"

#
# raspirec のポート番号
#
export PORT="45678"

#
# HLSモニタ機能 yes=有効
#
export HLS="no"

#
# arib ライブラリに何を使うのか libarib25 or libaribb25 の選択
#
#   libarib25  = https://github.com/stz2012/libarib25
#   libaribb25 = https://github.com/tsukumijima/libaribb25
#
#export ARIBLIB="libarib25"
export ARIBLIB="libaribb25"

#
# libyakisoba を使うか yes=使う, no=使わない
#
export USE_YAKISOBA="no"
export BCAS_DIR="/usr/local/etc" # keyファイルの格納Dir

# docker REPOSITORY:TAG
export TARGET="raspirec:1.0"

# ユーザー名
export USERNAME=`id -u -n`

# デバイスドライバーの種類を選択
#SELTYPE="dvb"       # DVBデバイス        -> recdvb を使用
#SELTYPE="char"      # キャラクタデバイス -> recpt1 を使用
SELTYPE="auto"       # 自動判定


if [ "$SELTYPE" = "auto" ]
then
    if [ -c /dev/dvb/adapter0/frontend0 ]
    then
        echo "found $dev -> dvb dev"
        sleep 1
        SELTYPE="dvb"
    else
        for dev in \
            /dev/pt1video0  \
                /dev/pt3video0  \
                /dev/px4video0 
        do
            if [ -c $dev ]
            then
                echo "found $dev -> char dev"
                sleep 1
                SELTYPE="char"
                break
            fi
        done
    fi
fi

if [ "$SELTYPE" = "auto" ]
then
    echo "Error: device file not found"
    exit
fi

export MOUNT="--mount type=bind,src=${DDIR_H},dst=${DDIR_D}"
export MOUNT="$MOUNT -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro"
export PORTMAP="-p $PORT:4567"

export RASPIRECDIR="/usr/local/raspirec" 
export RASPIREC="$RASPIRECDIR/raspirec.rb" 
