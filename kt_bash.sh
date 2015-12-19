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

#cheching if outfile exists and writable
test -f $OUT && echo "$OUT exists" || exit 2
test -w $OUT && echo "$OUT is writable" || exit 2

# if USR is root, then he can write everywhere
if [ $USR == root ]
then
	ls -l $DIR > $OUT
else
	find $DIR -user $USR -exec echo {} >> $OUT \;
	find $DIR -perm o+w -exec echo {} >> $OUT \;
fi