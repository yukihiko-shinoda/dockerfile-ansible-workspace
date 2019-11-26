#!/usr/bin/env sh
set -eu
echo "root:${SSH_PASSWORD}" | chpasswd
/usr/sbin/sshd -D
