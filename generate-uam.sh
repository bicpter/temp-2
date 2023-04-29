#!/bin/bash
number=$(docker ps | grep debian:bullseye-slim | wc -l)
docker rm -f $(docker ps -aq --filter ancestor=debian:bullseye-slim) && sudo rm -rf /opt/uam_data
file_name=$number-docker-compose.yml && rm entrypoint.sh && rm $file_name
wget https://github.com/anhtuan9414/uam-docker/raw/master/uam-swarm/$file_name && wget https://github.com/anhtuan9414/uam-docker/raw/master/uam-swarm/entrypoint.sh
PBKEY=$1 docker-compose -f $file_name up -d
