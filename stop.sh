#!/bin/sh
#
#  停止
#

docker ps | grep raspirec |\
    sed 's/[\t ]\+/\t/g' | cut -f1 | while read id
do
    docker stop $id
done
    

echo
docker ps -a
echo
docker images
