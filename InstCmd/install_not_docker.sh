#!/bin/sh
#set -x

#
#  docker を使わずに、現環境にインストールする
#

. ./setting.sh

export TMP_DIR=$PWD

test -d Download || mkdir Download
( cd Download ; sh ../InstCmd/download.sh )

if [ "X$DEBUG" = "Xyes" ]
then
    if ruby testCmd/md5_chk.rb
    then
        echo "チェックサムは異常なし。"
    else
        echo "チェックサムに不整合がありました。。"
        exit
    fi
fi

sudo -E sh InstCmd/all.sh

test -d $DDIR_H || mkdir -p $DDIR_H
if [ ! -f ${DDIR_H}/config.rb ]
then
    cp InstCmd/config.rb   ${DDIR_H}
    if [ "$SELTYPE" = "dvb" ]
    then
        sed -i.bak '/^Recpt1_cmd/s/recpt1/recdvb/' ${DDIR_H}/config.rb
        sed -i.bak '/^EpgPatchEnable/s/true/false/' ${DDIR_H}/config.rb
    fi

    if [ "$HLS" = "yes" ]
    then
        sed -i.bak '/^MonitorFunc/s/false/true/' ${DDIR_H}/config.rb
    fi

    if [ "$MPV" = "yes" ]
    then
        sed -i.bak '/^MPMonitor/s/false/true/' ${DDIR_H}/config.rb
    fi

    sed -i.bak '/^DataDir/s#/raspirec#'${DDIR_H}'#' ${DDIR_H}/config.rb

fi

