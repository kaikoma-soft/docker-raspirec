#!/bin/sh
#set -x

. ./setting.sh

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

if grep Raspbian /etc/os-release > /dev/null
then
    echo "Raspbian"
    sed -i.bak '/^FROM/s/ubuntu:.*/raspbian\/stretch:latest/' Dockerfile
fi

tar -cvf 2docker.tar Download InstCmd testCmd

docker build -t ${TARGET} \
       --build-arg DDIR_D=$DDIR_D \
       --build-arg HLS=$HLS \
       --build-arg RASPIRECDIR=$RASPIRECDIR \
       --build-arg USERNAME=$USERNAME \
       --build-arg DEBUG=$DEBUG \
       --build-arg ARIBLIB=$ARIBLIB \
       --build-arg USE_YAKISOBA=$USE_YAKISOBA \
       --build-arg BCAS_DIR=$BCAS_DIR \
       -f Dockerfile .

rm -f 2docker.tar

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

  
docker images
