
allLogs=""
file="/var/log/apache2/access.log"

function countingCurlAccess(){
results=$(cat "$file" | grep curl | cut -d' ' -f3 | sort | uniq -c | sort -nr )
}

countingCurlAccess
echo "$results"
