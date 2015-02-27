#!/bin/sh
export LC_ALL=C
printf "Starting container at "; date;
/usr/sbin/sshd -D &
/usr/local/bin/mongod --dbpath /data/db --journal