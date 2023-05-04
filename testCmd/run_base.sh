#!/bin/sh
#
#  raspirec:base からの bash の実行
#

if [ "X$DEBUG" = "Xyes" ]
then
    set -x
fi

. ./setting.sh

export TMP_DIR="/tmp/raspirec"
OPT="--privileged --stop-timeout 1 --stop-signal 9 -w $TMP_DIR "
RUNOPT="-d"
TARGET="raspirec:base"
OPT="$OPT --rm "
NAME="test"

docker run $RUNOPT $OPT $MOUNT $USERDATA $PORTMAP --name ${NAME} $TARGET sleep 3600
sleep 1
docker ps -a

tar -cvf - Download InstCmd testCmd setting.sh | docker exec -i ${NAME} tar Cxf /tmp/raspirec -

CMD="/bin/bash"
RUNOPT="-it"

docker exec $RUNOPT ${NAME} $CMD

docker stop ${NAME}

docker ps -a
docker images
