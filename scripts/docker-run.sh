#!/usr/bin/env bash
set -e

IMAGE="yesbit/miner"
CONTAINER="miner"

[[ $(sudo docker ps -f "name=$CONTAINER" --format '{{.Names}}') == "$CONTAINER" ]] ||
    sudo docker run --restart unless-stopped -d -p 3006:3006 -v config:/app/config --name="$CONTAINER" $IMAGE:latest
