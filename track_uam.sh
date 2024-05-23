#!/bin/bash
echo $(date +"%Y-%m-%d %H:%M:%S")
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
while true; do
    currentblock=$(curl -s https://utopian.is/api/explorer/blocks/get | grep -o '"block":[0-9]*' | awk -F: '{print $2}' | head -n 1)
    if [ -n "$currentblock" ]; then
        break
    else
        echo "Failed to fetch current block from the API. Retrying in 5 seconds..."
        sleep 5
    fi
done
echo -e "${GREEN}Current Block: $currentblock${NC}"
block=$((currentblock - 24))
allthreads=$(docker ps --format '{{.Names}}|{{.Status}}' --filter ancestor=debian:bullseye-slim | awk -F\| '{print $1}')
for val in $allthreads; do $(sudo docker restart $val); done;
