#!/bin/sh
#set -x

. ./setting.sh

test -d Download || mkdir Download
( cd Download ; sh ../InstCmd/download.sh )

if grep Raspbian /etc/os-release > /dev/null
then
    echo "Raspbian"
    sed -i.bak '/^FROM/s/ubuntu:.*/raspbian\/stretch:latest/' Dockerfile
fi


docker build -t ${TARGET} \
       --build-arg DDIR_D=$DDIR_D \
       --build-arg HLS=$HLS \
       --build-arg RASPIRECDIR=$RASPIRECDIR \
       --build-arg USERNAME=$USERNAME \
       -f Dockerfile .

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
