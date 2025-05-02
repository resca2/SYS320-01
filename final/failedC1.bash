#!/bin/bash
#fetch ioc page
IOC_URL="http://10.0.17.6/IOC.html"

#use curl and extract all IOC patterms from the html table

curl -s "$IOC_URL" > ioc_page.html

grep -oE 'cmd=[^"& ]+|/bin/[a-z]+|/etc/passwd|1=1--?' ioc_page.html > raw_iocs.txt

cat raw_iocs.txt | tr '+' '\n' | sed 's/%2F/\//g' | sed 's/%20/ /g' | sort -u > IOC.txt

rm ioc_page.html raw_iocs.txt

