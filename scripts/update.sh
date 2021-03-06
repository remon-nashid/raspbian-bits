#!/usr/bin/env bash
set -e

IMAGE="yesbit/miner"

sudo docker pull $IMAGE

CID=$(sudo docker ps | grep 'miner' | awk '{print $1}')
LATEST=$(sudo docker inspect --format "{{.Id}}" $IMAGE)
RUNNING=$(sudo docker inspect --format "{{.Image}}" "$CID")
CONTAINER=$(sudo docker inspect --format '{{.Name}}' "$CID" | sed "s/\///g")


echo "IMAGE: $IMAGE"
echo "CID: $CID"
echo "RUNNING: $RUNNING"
echo "LATEST: $LATEST"
echo "CONTAINER: $CONTAINER"

if [ "$RUNNING" != "$LATEST" ];then
    echo "updating $CONTAINER"
    sudo docker stop "$CONTAINER"
    sudo docker wait "$CONTAINER"
    sudo docker rm -f "$CONTAINER"
    bash /home/pi/raspbian-bits/scripts/docker-run.sh
else
    echo "$CONTAINER is already up to date"
fi
