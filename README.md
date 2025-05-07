# SpringCloudConfigServer
Simple implementation of an external configuration server for SpringBoot applications. 

## Build

### 1. Build Source Code

If you are using an `application.properties` file to set any configuration values, make sure the file exists in the `src/main/resources/` folder with the `application.yml` file.

- `mvn clean package`


### 2. Build the Docker Image

- `docker build -t <image-name:tag> .`

Since we have three different configurations being used, we can containerize each service with a different tag.

##### 2.1. Build Docker Image to use a .env file 

- ex: `docker build -t spring-app:env-config .`

##### 2.2. Build Docker Image to use a application.properties file 

- ex: `docker build -t spring-app:props-config .`

##### 2.3. Build Docker Image to use a application.properties file with External Configuration

- ex: `docker build -t spring-app:cloud-config .`


### Run the Service

Since we have three different configurations being used, we can run each service with a different configuation process.


#### Running Service with ".env" file for configuration
##### Run via CLI

- `source .env && docker run -p 8080:8080 <image-name:tag>`

- ex: `source .env && docker run -p 8080:8080 spring-app:env-config`


###### Run via Docker Compose

- `source .env && docker compose -f <compose-file.yml> up`

- ex: `source .env && docker compose -f spring-app-env.yml up`


#### Running Service with "application.properties" file for configuration
##### Run via CLI

- `docker run -p 8080:8080 <image-name:tag>`

- ex: `docker run -p 8080:8080 spring-app:props-config`


###### Run via Docker Compose

- `source .env && docker compose -f <compose-file.yml> up`

- ex: `source .env && docker compose -f spring-app-props.yml up`


#### Running Service with "application.properties" file for external configuration

- `docker run -p 8080:8080 <image-name:tag>`

- ex: `docker run -p 8080:8080 spring-app:cloud-config`


###### Run via Docker Compose

- `docker compose -f <compose-file.yml> up`

- ex: `docker compose -f spring-app-cloud.yml up`
