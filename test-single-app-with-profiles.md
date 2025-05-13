# Testing the Configuration of the Same Service using Different Profiles

This document captures the steps to test the configuration of a Spring Boot Service with a Single Spring Cloud Config Server.


## Building and Running the Spring Cloud Config Server

With the proper *.properties files in the `cloud-config/server/src/main/resources/config/` directory to match, we can start the server with the script below:

    build-run-cloud-config-server.sh

This should start the Cloud Config Server that is accessible via http://cloud-config-server:8888/<application-name>/<profile>/

ex: http://cloud-config-server:8888/test-app/profile1/


## Building Unique Service with a Profile

From the `config/` directory we have 3 instances of an application.properties file and application.yml file for each profile

- test-app-profile1-application.yml AND test-app-profile1.properties
- test-app-profile2-application.yml AND test-app-profile2.properties
- test-app-profile3-application.yml AND test-app-profile3.properties

We can build and start an instance of the Spring Boot service with the desired profile by running one of the scripts below

- build-run-cloud-profile1.sh
- build-run-cloud-profile2.sh
- build-run-cloud-profile3.sh

Each script will copy over the unique application.yml and application.properties files from the `config/` directory into `test-app/src/main/resources/`.

It will the rebuild the Spring Boot Project with maven, create a Docker container for the new project, and then start the service with `docker compose`.

These service(s) will fail if the Spring Cloud Config Server is not running.

**NOTE**: Only one instance of this application will run at a time. Overwritting the profile for the application will overwrite the service that runs.

- So running `build-run-cloud-profile1.sh` will start the "test-app-profile1" but running `build-run-cloud-profile2.sh` will stop the previous service, and start a new service with "test-app-profile2".

## Verifying Success of Configuration

There are a few ways to determine if your configuration attempt has worked. A few ways are listed below:

### Server Side
1) From the termianl output of the service, see if the Cloud Config Server has deploy the proper *.properties files.

This may look like:


    cloud-config-server  | 2025-05-12T19:06:49.524Z  INFO 1 --- [config-server] [nio-8888-exec-4] o.s.c.c.s.e.NativeEnvironmentRepository  : Adding property source: Config resource 'class path resource [config/test-app-profile2.properties]' via location 'classpath:/config/'  

2) Navigate to the webpage that hosts the configuration in JSON format

Open a web browser and naivaget to: http://cloud-config-server:8888/test-app/profile1/ or a similar URL with the hostname, port, application name and profile.

Verify that you can see the proper configuartion that should be deployed from the appropriate *.properites file

### Client Side
1) From the termianl output of the service, see if the servie has started. Based on the confiurations provided the service should fail it is cannot fetch the configurations from the Cloud Config Server

2) Navigate to the webpage that hosts the application and its data

Open a web browser and navigate to: http://ip:port/app/config/ or a similar URL with the hostname, port, and `/app/config/` path for your service.

You can get the ip address from running:

    docker network inspect cloud-config-server
    # OR
    docker inspect test-app-profileX

Once you access the page you shoudl see output based on your configuration file on the Config Server. This may look similar to the content below:

    Message: "Hello Profile 3, from the Config Server (Service)!"
    Environment: "Cloud Test"
    Beta Enabled: true
    User: "Baby Doe"
    Role: Helper


Repeat this process for the other service(s) and configurations you want to test in this project and verify they all work.

