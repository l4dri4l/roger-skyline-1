#!/bin/bash

CRONFILE="/etc/crontab"

if ! cd /checksumroot/; then
	mkdir /checksumroot/
	chmod 700 /checksumroot/
	cd /checksumroot
	md5sum < $CRONFILE | cut -d\\ -f1 > oldmd5
fi

cd /checksumroot/

md5sum < $CRONFILE | cut -d\\ -f1 > tempmd5
chmod 700 tempmd5
if ! cmp --silent oldmd5 tempmd5 ; then
	echo "merde" | mail -s "Crontab changed alert" root
	rm -f $OLDMD5
	mv tempmd5 oldmd5
fi
