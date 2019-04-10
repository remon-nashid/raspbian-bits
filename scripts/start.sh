#!/usr/bin/env bash
set -e

IMAGE="remonyesbit/miner"

docker run -d -p 3006:3006 -v config:/app/config --name=miner $IMAGE:latest