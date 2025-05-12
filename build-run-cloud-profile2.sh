#!/bin/bash


# remove application.properties file and move '.env' file to current directory
cp config/test-app-profile2.properties test-app/src/main/resources/application.properties
cp config/test-app-profile2-application.yml test-app/src/main/resources/application.yml

cd test-app/

# build the source code 
mvn clean package

cd ../
# build the docker image
docker build -t test-app:profile2 .

# start the app with 'docker run'

#docker run -p 8082:8082  --name test-app-profile2 test-app:profile2

# OR start the app with 'docker compose'

docker compose -f test-app-profile2.yml up


