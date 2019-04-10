#!/usr/bin/env bash
set -e

IMAGE="remonyesbit/miner"

CID=$(docker ps | grep $IMAGE | awk '{print $1}')
CONTAINER=`docker inspect --format '{{.Name}}' $CID | sed "s/\///g"`