#!/bin/bash

pingsite () {
    curl --output /dev/null --connect-timeout 5 --max-time 20 --write-out "%{http_code} - $2 $3 expected for $4 [$1]\n" -s -S "$1"
}

while read -r line; do
    url=$(echo "$line" | cut -d ',' -f 1)
    response_code=$(echo "$line" | cut -d ',' -f 2)
    response_description=$(echo "$line" | cut -d ',' -f 3)
    deployment=$(echo "$line" | cut -d ',' -f 4)

    pingsite "$url" "$response_code" "$response_description" "$deployment"
done
