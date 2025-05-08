#!/bin/bash

# remove application.properties file and move '.env' file to current directory
mv src/main/resources/application.properties config/

# build the source code 
mvn clean package

# build the docker image
docker build -t spring-app:env-config .

# start the app

#source .env && docker run -p 8080:8080 -e MESSAGE=${MESSAGE} -e  ENVIRONMENT=${ENVIRONMENT} -e  NAME=${NAME} -e ROLE=${ROLE} spring-app:env-config