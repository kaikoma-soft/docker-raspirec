#!/bin/sh
#set -x

#
#  OS だけの image の作成
#

. ./setting.sh
export TARGET="raspirec:base"

docker build -t ${TARGET} \
       --build-arg DDIR_D=$DDIR_D \
       --build-arg HLS=$HLS \
       --build-arg SC=$SC \
       --build-arg RASPIRECDIR=$RASPIRECDIR \
       --build-arg USERNAME=$USERNAME \
       --build-arg DEBUG=$DEBUG \
       --build-arg ARIBLIB=$ARIBLIB \
       --build-arg USE_YAKISOBA=$USE_YAKISOBA \
       --build-arg BCAS_DIR=$BCAS_DIR \
       -f testCmd/base_Dockerfile .

docker ps -a
docker images
