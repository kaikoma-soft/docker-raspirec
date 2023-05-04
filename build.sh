#!/bin/sh
#set -x

. ./setting.sh

test -d Download || mkdir Download
( cd Download ; sh ../InstCmd/download.sh )

if [ "X$DEBUG" = "Xyes" ]
then
    if [ -x /usr/bin/ruby ]
    then
        if ruby testCmd/md5_chk.rb
        then
            echo "チェックサムは異常なし。"
        else
            echo "チェックサムに不整合がありました。。"
            exit
        fi
    fi
fi

if [ "$DOCKER" = "yes" ]
then
    #
    # docker 環境にインストールする。
    #
    if grep Raspbian /etc/os-release > /dev/null
    then
        echo "Raspbian"
        sed -i.bak '/^FROM/s/ubuntu:.*/raspbian\/stretch:latest/' Dockerfile
    fi

    tar -cvf 2docker.tar Download InstCmd testCmd

    docker build -t ${TARGET} \
           --build-arg DDIR_D=$DDIR_D \
           --build-arg TMP_DIR=$TMP_DIR \
           --build-arg SRC_DIR=$SRC_DIR \
           --build-arg HLS=$HLS \
           --build-arg RASPIRECDIR=$RASPIRECDIR \
           --build-arg USERNAME=$USERNAME \
           --build-arg DEBUG=$DEBUG \
           --build-arg ARIBLIB=$ARIBLIB \
           --build-arg USE_YAKISOBA=$USE_YAKISOBA \
           --build-arg BCAS_DIR=$BCAS_DIR \
           -f Dockerfile .

    rm -f 2docker.tar
else
    #
    # docker を使わずに現環境にインストールする。
    #
    sudo -E sh InstCmd/all.sh
    sed -i.bak '/^DataDir/s#/raspirec#'${DDIR_H}'#' InstCmd/config.rb
fi

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
fi

  
if [ "$DOCKER" = "yes" ]
then
    docker images
else
    cat InstCmd/start_not_docker.sh |\
        sed -e 's#XXXX#'${DDIR_H}'#' -e 's#YYYY#'${RASPIRECDIR}'#' \
            > ${DDIR_H}/raspirec.sh
fi
