#!/usr/bin/env bash
set -e

IMAGE="remonyesbit/miner"
CONTAINER="miner"

[[ $(docker ps -f "name=$CONTAINER" --format '{{.Names}}') == "$CONTAINER" ]] ||
    docker run --restart unless-stopped -d -p 3006:3006 -v config:/app/config --name="$CONTAINER" $IMAGE:latest
