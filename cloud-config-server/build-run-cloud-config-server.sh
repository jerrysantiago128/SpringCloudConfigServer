#!/bin/bash

# build the source code 
mvn clean package


# build the docker image
docker build -t cloud-config-server:0.0.1 .

# start the app with 'docker run'

#docker run -p 8888:8888 cloud-config-server:0.0.1

# OR start the app with 'docker compose'

docker compose -f cloud-config-server.yml up