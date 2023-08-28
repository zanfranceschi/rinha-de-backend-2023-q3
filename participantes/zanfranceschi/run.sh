#!/usr/bin/bash

docker-compose rm -f
docker-compose down --rmi all
docker-compose up --build
