#!/bin/bash

# remove application.properties file and move '.env' file to current directory
cp config/test-app-profile3.properties test-app/src/main/resources/application.properties
cp config/test-app-profile3-application.yml test-app/src/main/resources/application.yml

cd test-app/

# build the source code 
mvn clean package

cd ../
# build the docker image
docker build -t test-app:profile3 .

# start the app with 'docker run'

#docker run -p 8083:8083  --name test-app-profile3 test-app:profile3

# OR start the app with 'docker compose'

docker compose -f test-app-profile3.yml up