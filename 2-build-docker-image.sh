#!/bin/bash

cd serge
GIT_SHA1=`git rev-parse --short HEAD`
cd ..
echo "Building from SHA-1 $GIT_SHA1"

SERGE_BUILD="Smartcat Docker image / Serge SHA-1: $GIT_SHA1

Update:
    docker pull smartcatcom/serge

More info:
    https://smartcat.ai"


docker build \
    --build-arg GIT_SHA1="$GIT_SHA1" \
    --build-arg SERGE_BUILD="$SERGE_BUILD" \
    -t smartcatcom/serge \
    -f Dockerfile \
    .
