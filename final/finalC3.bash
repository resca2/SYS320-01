#!/bin/bash

HTMLFILE="/var/www/html/report.html"

{
echo "<html>"
echo "<body>"
echo "<h3>Access logs with IOC indicators:</h3>"
echo "<table border='1'>"
while IFS= read -r line; do
	ip=$(echo "$line" | awk '{print $1}')
	datetime=$(echo "$line" | awk '{print $2}')
	time=$(echo "$line" | awk '{print $3}')
	page=$(echo "$line" | cut -d' ' -f4-)
	echo "<tr><td>$ip</td><td>$datetime:$time</td><td>$page</td></tr>"
done < report.txt
echo "</table>"
echo "</body>"
echo "</html>"
} > "$HTMLFILE"
