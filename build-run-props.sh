#!/bin/bash

# remove application.properties file and move '.env' file to current directory
cp config/application.properties test-app/src/main/resources/application.properties

cd test-app/ 

# build the source code 
mvn clean package


cd ../

# build the docker image
docker build -t spring-app:props-config .

# start the app with 'docker run'

docker run -p 8080:8080 spring-app:props-config

# OR start the app with 'docker compose'

#docker compose -f spring-app-props.yml up