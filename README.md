# SpringCloudConfigServer
Simple implementation of an external configuration server for SpringBoot applications. 


## Configure your system

### Install Docker

#### Remove old Docker and/or Podman installations

`sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine podman runc`

#### Grab the Docker '.repo' file

`sudo yum install -y yum-utils`
`sudo yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo`

#### Install Docker from Yum
`sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y`

#### Enable and Start Docker
`sudo systemctl enable --now docker`
`sudo systemctl start docker.service`

#### Verify
Verify the installation works with `docker ps`

**Note:** You may need to restart your system

### Install Maven and Java 17
sudo yum install -y maven java-17-openjdk java-17-openjdk-devel 

Verify installation and add java to your ~/.bashrc file if needed


## Build

### 1. Build Source Code

`cd test-app`

If you are using an `application.properties` file to set any configuration values, make sure the file exists in the `src/main/resources/` folder with the `application.yml` file.

- `mvn clean package`


### 2. Build the Docker Image

`cd ../`

- `docker build -t <image-name:tag> .`

Since we have three different configurations being used, we can containerize each service with a different tag.

##### 2.1. Build Docker Image to use a .env file 

- ex: `docker build -t spring-app:env-config .`

##### 2.2. Build Docker Image to use a application.properties file 

- ex: `docker build -t spring-app:props-config .`

##### 2.3. Build Docker Image to use a application.properties file with External Configuration

- ex: `docker build -t spring-app:cloud-config .`


## Run the Service

Since we have three different configurations being used, we can run each service with a different configuation process.


#### Running Service with ".env" file for configuration **DOES NOT WORK AS INTENDED BUT WORKS AS LISTED BELOW**
##### Run via CLI

- `source .env && docker run -p 8080:8080 -e VALUE1=VAR ... <image-name:tag>`

- ex: 
```
source .env && docker run -p 8080:8080 -e MESSAGE="Hello from .env file" \
    -e  ENVIRONMENT="The Islands" \
    -e  NAME=Domingo              \
    -e ROLE=Senor                 \
    spring-app:env-config
    
```

###### Run via Docker Compose

- `source .env && docker compose -f <compose-file.yml> up`

- ex: `source .env && docker compose -f spring-app-env.yml up`


#### Running Service with "application.properties" file for configuration
##### Run via CLI

- `docker run -p 8080:8080 <image-name:tag>`

- ex: `docker run -p 8080:8080 spring-app:props-config`


###### Run via Docker Compose

- `docker compose -f <compose-file.yml> up`

- ex: `docker compose -f spring-app-props.yml up`


#### Running Service with "application.properties" file for external configuration

- `docker run -p 8080:8080 <image-name:tag>`

- ex: `docker run -p 8080:8080 spring-app:cloud-config`


###### Run via Docker Compose

- `docker compose -f <compose-file.yml> up`

- ex: `docker compose -f spring-app-cloud.yml up`

## Accessing the Service

### 1. Via Browser

Open your browser of choice and navigate to `http://localhost:8080/app/config/`

Here you should see an output similar to the following format:

```
Message: Overridden message from application.properties
Environment: from properties
Beta Enabled: false
User: admin
Role: ADMIN
```

### Via CLI using 'curl'

From your terminal run the curl command below

`curl http://ip:port/path/to/resource`

`curl http://localhost:8080/app/config`

Here you should see an output similar to the one below based on your serivce setup:

```
Message: Overridden message from application.properties<br>Environment: from properties<br>Beta Enabled: false<br>User: admin<br>Role: ADMIN
```


# To Configure with Spring Cloud Config Server

Reference the link below to Spin up a Spring Cloud Config Server and Client


https://docs.spring.io/spring-cloud-config/docs/current/reference/html/#_quick_start

Build and Configure the Server in the `cloud-config-server/` directory

There is a README.md file in the `cloud-config-server/` directory with notes on building and running the Cloud Server as a service.