#!/bin/bash

# remove application.properties file and move '.env' file to current directory
cp config/application.properties src/main/resources/application.properties
rm .env 

# build the source code 
mvn clean package

# build the docker image
docker build -t spring-app:cloud-config .

# start the app with 'docker run'

docker run -p 8080:8080 spring-app:cloud-config

# OR start the app with 'docker compose'

#docker compose -f spring-app-cloud.yml up