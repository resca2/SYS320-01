#!bin/bash
allLogs=""
file="/var/log/apache2/access.log"


function GetAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f1,4,7 | tr -d "[")
}

function ips(){
ipsAccessed=$(echo "$allLogs" | cut -d' ' -f1)
}

function pageCount(){
pagesAmount=$(cat "$file" | grep "curl/" | cut -d' ' -f1,12 | sort | uniq -c)
}

pageCount
echo "$pagesAmount"


