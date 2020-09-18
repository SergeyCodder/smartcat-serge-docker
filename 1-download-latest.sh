#!/bin/bash

[ -e serge ] && rm -rf serge
git clone --depth 1 https://github.com/evernote/serge.git

rm -rf serge/docker
rm -rf serge/t
