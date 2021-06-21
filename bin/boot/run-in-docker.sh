#!/bin/sh
set -e

. /usr/local/bin/boot/bootstrap.sh

/usr/bin/dumb-init -- "$@"