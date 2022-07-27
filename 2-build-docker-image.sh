#!/bin/bash

cd serge
GIT_SHA1=`git rev-parse --short HEAD`
cd ..
echo "Building from SHA-1 $GIT_SHA1"

value=$(<.version)
SERGE_BUILD="Smartcat Docker image with dotnet cli ($value) / Serge SHA-1: $GIT_SHA1

Update:
    docker pull docker-registry.smartcat.ai/serge-dotnet:$value

More info:
    https://smartcat.ai"


docker build \
    --build-arg GIT_SHA1="$GIT_SHA1" \
    --build-arg SERGE_BUILD="$SERGE_BUILD" \
    -t sderunov/serge-dotnet:"$value" \
    -f Dockerfile \
    .

sleep 5
