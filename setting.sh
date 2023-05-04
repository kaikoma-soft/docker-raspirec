#!/bin/sh

VERSION="1.3.1"

export DOCKER="yes"             # docker にインストールするか yes/no
export TMP_DIR="/tmp/raspirec"  # 作業dir

if [ "$DOCKER" = "yes" ]
then
    DDIR_H="$HOME/docker-raspirec" # HOST側のデータディレクトリ
    DDIR_D="/raspirec"             # Docker側のデータディレクトリ
    SRC_DIR="$TMP_DIR"             # ソースの置き場所
else
    DDIR_H="$HOME/raspirec"
    DDIR_D="$DDIR_H"
    SRC_DIR="$PWD"
fi

export DOCKER TMP_DIR DDIR_H DDIR_D SRC_DIR

#
# arib ライブラリに何を使うのか libarib25 or libaribb25 の選択
#
#   libarib25  = https://github.com/stz2012/libarib25
#   libaribb25 = https://github.com/tsukumijima/libaribb25
#
ARIBLIB="libarib25"
#ARIBLIB="libaribb25"

USE_YAKISOBA="no"                 # libyakisoba を使うか yes=使う
BCAS_DIR="/usr/local/etc"          # keyファイルの格納Dir

RASPIRECDIR="/usr/local/raspirec"  # raspirec のインストールディレクトリ
TARGET="raspirec:1.0"              # docker REPOSITORY:TAG
USERNAME=`id -u -n`                # ユーザー名
PORT="45678"                       # raspirec のポート番号
HLS="no"                           # HLSモニタ機能 yes=有効

export ARIBLIB USE_YAKISOBA BCAS_DIR RASPIRECDIR TARGET USERNAME PORT HLS

#
# デバイスドライバーの種類を選択
#
SELTYPE="auto"       # 自動判定
#SELTYPE="dvb"       # DVBデバイス        -> recdvb を使用
#SELTYPE="char"      # キャラクタデバイス -> recpt1 を使用

export SELTYPE

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

export RASPIREC="$RASPIRECDIR/raspirec.rb" 

test -d $TMP_DIR || mkdir $TMP_DIR

