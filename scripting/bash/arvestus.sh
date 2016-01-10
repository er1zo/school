#!/bin/bash
if [ $# -eq 3 ]; then 
	RFILE=$1
	WFILE=$2
	SEARCH=$3
else
	echo "USAGE: FILE_TO_READ FILE_TO_WRITE WHAT_TO_SEARCH"
	exit 3
fi

test -r $RFILE && echo "$RFILE readable" || exit 1
test -w $WFILE && echo "$WFILE writable" || exit 2

cat $SEARCH > $WFILE

while IFS='' read -r line || [[ -n "$line" ]]; do
    if [ -f $line ]; then
		grep -q $SEARCH $line
		if [ $? -eq 0 ]; then
			cat "$line, OLEMAS" >> $WFILE
		else
			cat "$line, POLE OLEMAS" >> $WFILE
		fi

	elif [ -d $line]; then
		find $line -name '*$SEARCH*'
		if [ $? -eq 0 ]; then
			cat "$line, OLEMAS" >> $WFILE
		else
			cat "$line, POLE OLEMAS" >> $WFILE
		fi
	fi
done < "$RFILE"