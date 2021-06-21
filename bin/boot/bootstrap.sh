#!/bin/sh
set -e

. /root/.env

if test ! -e "/root/.initialized"; then
    echo -e "\033[01;34mInitializing the project\033[00m"
    /usr/local/bin/boot/initialize.sh
    touch /root/.initialized
fi

# Ensure proper permissions on files inside .ssh directory.
#
# Note that under a Windows host, file permissions
# will be reported incorrectly by `ls -l` (as 755),
# but will still work.

chmod 700 /root/.ssh
if test -e "/root/.ssh/*"; then
    chmod 600 /root/.ssh/*
fi
if test -e "/root/.ssh/*.pub"; then
    chmod -f 644 /root/.ssh/*.pub
fi
