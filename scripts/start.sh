#!/usr/bin/env bash
set -e
set -x

IMAGE="remonyesbit/miner"

# If image is there just start it
# if it's started do nothing

CID=$(docker ps -a | grep $IMAGE | awk '{print $1}')
echo "CID: $CID"
if [[ -z "$CID" ]] 
then 
    echo "No container found. Will start now."    
    docker run -d -p 3006:3006 -v config:/app/config --name=miner $IMAGE:latest
fi


CONTAINER=$(docker inspect --format '{{.Name}}' "$CID" | sed "s/\///g")
echo "CONTAINER: $CONTAINER"
docker start "$CONTAINER"