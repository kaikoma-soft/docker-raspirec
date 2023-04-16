#!/bin/sh
#
#  実行
#
#set -x

. ./setting.sh

test -d $DDIR_H || mkdir -p $DDIR_H

OPT="--privileged"
NAME="--name raspirec"
RUNOPT="-d $NAME"

if [ "$1" = "bash" ]             # デバック用に bash を起動
then
    CMD="/bin/bash"
    RUNOPT="-it $NAME"
fi

docker run $RUNOPT $OPT $MOUNT $USERDATA $PORTMAP --rm $TARGET $CMD
sleep 1

#
#  ホスト側の key ファイルを docker 側にコピーする。
#
if [ "$CMD" = "" -a "$USE_YAKISOBA" = "yes" -a "X$BCAS_KEYS_FILE" != "X" ]
then
    set -x
    if [ -f "$BCAS_KEYS_FILE" ]
    then
        ID=`docker ps | grep raspirec | cut -d " " -f1`
        if [ "$ID" != "" ]
        then
            docker cp  "$BCAS_KEYS_FILE"   ${ID}:${BCAS_DIR}/bcas_keys
            docker commit ${ID} $TARGET
        fi
    fi
fi
    
docker ps
