#!/bin/bash
# scriptimiskeeled bashi kontrolltoo 19.12

#checking if there are 3 args, otherwise exit 3
if [ $# -eq 3 ]
then
	DIR=$1
	USR=$2
	OUT=$3
else
	echo "usage: DIR USR OUT"
	exit 3
fi

#checking if user and directory exists, otherwise exit 1
test -d $DIR && echo "$DIR exists" || exit 1
getent passwd $USR && echo "$USR exists" || exit 1

#cheching if outfile is writable
test -w $OUT && echo "$OUT is writable" || exit 2

