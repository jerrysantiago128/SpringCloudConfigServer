#!/bin/bash

# remove application.properties file and move '.env' file to current directory
cp config/cloud-config.properties test-app/src/main/resources/application.properties

cd test-app/

# build the source code 
mvn clean package

cd ../
# build the docker image
docker build -t spring-app:cloud-config .

# start the app with 'docker run'

#docker run -p 8080:8080  --name spring-app-cloud spring-app:cloud-config

# OR start the app with 'docker compose'

docker compose -f spring-app-cloud.yml up