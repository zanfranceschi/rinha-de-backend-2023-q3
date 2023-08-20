#!/bin/bash

docker-compose rm -f
docker-compose down
docker-compose -f docker-compose.yml up --build -d
