#!/bin/sh
#
#  コンテナとイメージを全削除
#

docker ps -s | grep raspirec |\
    sed 's/[\t ]\+/\t/g' | cut -f1 | while read id
do
    docker rm $id
done

docker images | grep raspirec |\
    sed 's/[\t ]\+/\t/g' | cut -f3 | while read id
do
    docker rmi $id
done


echo
docker ps -a
echo
docker images
