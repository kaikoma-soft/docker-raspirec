#!/bin/sh
#
#  実行
#
#set -x

. ./setting.sh

test -d $DDIR_H || mkdir -p $DDIR_H

OPT="--privileged"
MOUNT="--mount type=bind,src=${DDIR_H},dst=${DDIR_D}"
MOUNT="$MOUNT -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro"
PORTMAP="-p $PORT:4567"

RUNOPT="-d"
#CMD="/bin/sh $RASPIRECDIR/start.sh"
if [ "$1" = "bash" ]
then
    CMD="/bin/bash"
    RUNOPT="-it"
fi

docker run $RUNOPT $OPT $MOUNT $USERDATA $PORTMAP --rm $TARGET $CMD
sleep 1
docker ps
