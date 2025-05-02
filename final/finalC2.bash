#!/bin/bash

LOGFILE="$1"
IOCFILE="$2"
REPORT="report.txt"

#bug fixing
if [ ! -f "$LOGFILE" ]; then
	echo "Log file '$LOGFILE' not found!"
	exit 1
fi

if [ ! -f "$IOCFILE" ]; then
	echo "IOC file '$IOCFILE' not found!"
	exit 1
fi

#clear previous report
> "$REPORT" 

#loops for every IOC entry
while IFS= read -r line; do
#grep matching lines from access log
	grep --no-filename "$ioc" "$LOGFILE" | while read -r line; do
		#extracr ip, timestamp, and requested resource
		if echo "$line" | grep -q "$ioc"; then
			ip=$(echo "$line" | awk '{print $1}')
			datetime=$(echo "$line" | awk -F'[][]' '{print $2}')
			page=$(echo "$line" | awk -F'"' '{print $2}' | awk '{print $2}')
			echo "$ip $datetime $page" >> "$REPORT"
			break
		fi
	done
done < "$LOGFILE"

echo "REPORT saved to $REPORT"
