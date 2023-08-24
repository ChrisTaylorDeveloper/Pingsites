#!/bin/bash

pingsite () {
    curl --output /dev/null --connect-timeout 5 --max-time 20 --write-out "%{http_code}" -s -S "$1"
}

tbl=$(printf "ACTUAL RESPONSE\tEXPECTED RESPONSE\tDEPLOYMENT\tURL")

while read -r line; do
    url=$(echo "$line" | cut -d ',' -f 1)
    expected=$(echo "$line" | cut -d ',' -f 2)
    deploy=$(echo "$line" | cut -d ',' -f 4)
    actual=$(pingsite "$url")
    tbl+=$'\n'$actual$'\t'$expected$'\t'$deploy$'\t'$url
done

echo "$tbl" | column -t -s $'\t'
