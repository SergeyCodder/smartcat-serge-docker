#!/bin/bash

[ -e serge ] && rm -rf serge
git clone --depth 1 https://github.com/evernote/serge.git

rm -rf serge/docker
rm -rf serge/t

rm -f bin/smartcat
curl -o bin/smartcat -L "https://smartcat-cli.s3.amazonaws.com/linux/smartcat"

sleep 5
