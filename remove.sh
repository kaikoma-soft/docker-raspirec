#!/bin/sh
#
#  コンテナとイメージを全削除
#

if [ "X$1" = "X-n" ]
then
    TARGET="(raspirec|none)"
else
    TARGET="raspirec"
fi
    
docker ps -s | egrep "$TARGET" |\
    sed 's/[\t ]\+/\t/g' | cut -f1 | while read id
do
    docker rm $id
done

docker images | egrep "$TARGET" |\
    sed 's/[\t ]\+/\t/g' | cut -f3 | while read id
do
    docker rmi $id
done


echo
docker ps -a
echo
docker images
