#!/bin/bash

# remove application.properties file and move '.env' file to current directory
#cp ../config/secure-test-app-plaintext.properties ../secure-test-app/src/main/resources/application.properties

cd ../secure-test-app/

# build the source code 
mvn clean package


# build the docker image
docker build -t secure-test-app:ssl .

# start the app with 'docker run'

#docker run -p 8081:8081  --name test-app-profile1 test-app:profile1

# OR start the app with 'docker compose'
cd ../compose/

docker compose -f secure-test-app-ssl.yml up

