#!/usr/bin/env bash
set -e

IMAGE="remonyesbit/miner"

CID=$(docker ps | grep $IMAGE | awk '{print $1}')
LATEST=`docker inspect --format "{{.Id}}" $IMAGE`
RUNNING=`docker inspect --format "{{.Image}}" $CID`
CONTAINER=`docker inspect --format '{{.Name}}' $CID | sed "s/\///g"`

docker pull $IMAGE

echo "IMAGE:" $IMAGE
echo "CID:" $CID
echo "RUNNING:" $RUNNING
echo "LATEST:" $LATEST
echo "CONTAINER:" $CONTAINER

if [ "$RUNNING" != "$LATEST" ];then
    echo "updating $CONTAINER"
    docker stop $CONTAINER
    docker wait $CONTAINER
    docker rm -f $CONTAINER
    ./start.sh
else
    echo "$CONTAINER is already up to date"
fi