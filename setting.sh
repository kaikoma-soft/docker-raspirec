#!/bin/sh

# HOST側のデータディレクトリ
DDIR_H="$HOME/docker-raspirec"

# Docker側のデータディレクトリ
DDIR_D="/raspirec"

# raspirec のポート番号
PORT="45678"

# HLSモニタ機能 yes=有効
HLS="no"

# docker REPOSITORY:TAG
TARGET="raspirec:1.0"

# ユーザー名
USERNAME=`id -u -n`

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


export RASPIRECDIR="/usr/local/raspirec" 
export RASPIREC="$RASPIRECDIR/raspirec.rb" 
