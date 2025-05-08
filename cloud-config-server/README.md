# Spring Cloud Config Server

Simple implementation of a Spring Cloud Config Server for usign external configuration of a SpringBoot Application.


## Build

### 1. Build the Source Code

If you are using an `application.properties` file to set any configuration values, make sure the file exists in the `src/main/resources/` folder with the application.yml file.

Ensure any configuration instances you want other services to use exists in the `src/main/resources/config/` directory and are named `<app-profile>.properties`

After this you can build the source code using the command below

`mvn clean package`

### 2. Build the Docker Image

If you plan on running the server via Docker, create a Docker image that we can use later

` docker build -t <server-name:tag> .`

- ex: ` docker build -t cloud-config-server:0.0.1 .`


## Run the Service

### 1. Via Maven and CLI

`mvn sprin-boot:run`

You should see the service start in the terminal.

### 2. Run with Docker run

`docker run -p <port:port> <server-name:tag>`

ex: `docker run -p 8888:8888 cloud-config-server:0.0.1`

### 3. Run with Docker Compose

#### 3.1 Create a Docker Network to run the services within:

`docker network create <my-network>`

ex: `docker network create cloud-config-network`


#### 3.2 Use the 'docker compose' command

`docker compose -f <file.yml> up`

ex: `docker compose -f cloud-config-server.yml up`


## Acessing the Service

### 1. Via Browser

Open your browser of choice and navigate to:

`http://{config-server-host}:{config-server-port}/{application}/{profile}`

where: 

{config-server-host}: The hostname or IP address of your Config Server.
{config-server-port}: The port the Config Server is listening on.
{application}: The name of the application (derived from the configuration file name).
{profile}: The active profile (derived from the configuration file name).

ex: `http://cloud-config-server:8888/spring-app-cloud/cloud/`

Here you should see an JSON output similar to the following format:

```
name	"spring-app-cloud"
profiles	
0	"cloud"
label	null
version	null
state	null
propertySources	
0	
name	"classpath:/config/spring-app-cloud-cloud.properties"
source	
message	'"Hello from the Config Server (Properties)!"'
environment	'"Cloud Production"'
name	"Rico"
role	"Practioner"
1	
name	"classpath:/config/application.properties"
source	
default.message	"Hello from the default config!"
```

### Via CLI using 'curl'

From your terminal run the curl command below

`curl http://{config-server-host}:{config-server-port}/{application}/{profile}`

where: 

{config-server-host}: The hostname or IP address of your Config Server.
{config-server-port}: The port the Config Server is listening on.
{application}: The name of the application (derived from the configuration file name).
{profile}: The active profile (derived from the configuration file name).

ex: `curl http://cloud-config-server:8888/spring-app-cloud/cloud/`

You may need to grab the ip address of the container with the following command(s):

` docker network inspect <network-name>`

ex: ` docker network inspect cloud-config-network`

And grab ip address of your container/service

Here you should see an output similar to the one below based on your serivce setup:

```
{"name":"spring-app-cloud","profiles":["cloud"],"label":null,"version":null,"state":null,"propertySources":[{"name":"classpath:/config/spring-app-cloud-cloud.properties","source":{"message":"\"Hello from the Config Server (Properties)!\"","environment":"\"Cloud Production\"","name":"Rico","role":"Practioner"}},{"name":"classpath:/config/application.properties","source":{"default.message":"Hello from the default config!"}}]}
```
