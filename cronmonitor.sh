#!/bin/bash

FILE="/var/tmp/checksum"
FILE_TO_WATCH="/var/spool/cron/crontabs/root"
MD5VALUE=$(sudo md5sum $FILE_TO_WATCH)

if [ ! -f $FILE ]
then
	echo "$MD5VALUE" > $FILE
	exit 0;
fi;

if [ "$MD5VALUE" != "$(cat $FILE)" ];
	then
	echo "$MD5VALUE" > $FILE
	echo "ATTENTION! $FILE_TO_WATCH is modified!" | mail -s "CRONTAB CHANGED" root@roger.lan
fi;
