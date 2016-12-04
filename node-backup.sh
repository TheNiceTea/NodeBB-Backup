#!/bin/bash

todaysdate=`date +%Y-%m-%d`

# make backup folder
cd /opt/nodebb-backups
mkdir $todaysdate

## stop server
cd /var/www/nodebb
./nodebb stop
sleep 2

## files
cd /var/www/
tar -zcvf /home/moderator/nodebb-backups/$todaysdate/nodebb-files.tar.gz nodebb

## database
redis-cli bgsave
sleep 10
cp /var/lib/redis/dump.rdb /opt/nodebb-backups/$todaysdate/dump.rdb

## start nodebb
cd /var/www/nodebb/
./nodebb start
