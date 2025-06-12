# Spring Boot Cloud Config Server and Client with SSL Configuration

This guide provides step-by-step instructions for setting up Spring Boot Cloud Config Server and Client with SSL certificates using Spring Boot 3.2.5 and application.yml configuration files.

## Prerequisites

- Java 17 or higher
- Maven or Gradle
- SSL certificates (self-signed or CA-signed)
- Spring Boot 3.2.5
- Spring Cloud 2023.0.x (compatible with Spring Boot 3.2.5)

## Spring Boot Cloud Config Server Setup

### 1. Create Config Server Project

Initialize a new Spring Boot project with the following dependencies:

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-config-server</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-security</artifactId>
    </dependency>
</dependencies>
```

### 2. Enable Config Server

Add the `@EnableConfigServer` annotation to your main application class:

```java
@SpringBootApplication
@EnableConfigServer
public class ConfigServerApplication {
    public static void main(String[] args) {
        SpringApplication.run(ConfigServerApplication.class, args);
    }
}
```

### 3. Configure SSL and Server Properties

Create `src/main/resources/application.yml`:

```yaml
server:
  port: 8888
  ssl:
    enabled: true
    key-store: classpath:keystore.p12
    key-store-password: changeit
    key-store-type: PKCS12
    key-alias: config-server
    trust-store: classpath:truststore.p12
    trust-store-password: changeit
    trust-store-type: PKCS12
    client-auth: need

spring:
  application:
    name: config-server
  profiles:
    active: native
  cloud:
    config:
      server:
        native:
          search-locations: classpath:/config-repo
        git:
          uri: https://github.com/your-org/config-repo
          clone-on-start: true
          default-label: main
        health:
          repositories:
            enabled: true

# Optional: Basic Authentication
security:
  user:
    name: config-user
    password: config-password

logging:
  level:
    org.springframework.cloud.config: DEBUG
    org.springframework.security: DEBUG
```

### 4. SSL Certificate Setup

Place your SSL certificates in `src/main/resources/`:
- `keystore.p12` - Server's private key and certificate
- `truststore.p12` - Trusted client certificates

### 5. Create Configuration Repository

Create a directory `src/main/resources/config-repo/` and add your application configuration files:

```
config-repo/
├── application.yml          # Default configuration for all applications
├── application-dev.yml      # Development profile configuration
├── application-prod.yml     # Production profile configuration
├── client-app.yml          # Configuration for specific client application
├── client-app-dev.yml      # Client app development configuration
└── client-app-prod.yml     # Client app production configuration
```

## Spring Boot Cloud Config Client Setup

### 1. Create Config Client Project

Initialize a new Spring Boot project with the following dependencies:

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-starter-config</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-actuator</artifactId>
    </dependency>
</dependencies>
```

### 2. Configure Client Application

Create `src/main/resources/application.yml`:

```yaml
server:
  port: 8080
  ssl:
    enabled: true
    key-store: classpath:client-keystore.p12
    key-store-password: changeit
    key-store-type: PKCS12
    key-alias: config-client
    trust-store: classpath:client-truststore.p12
    trust-store-password: changeit
    trust-store-type: PKCS12

spring:
  application:
    name: client-app
  profiles:
    active: dev
  config:
    import: "configserver:https://localhost:8888"
  cloud:
    config:
      uri: https://localhost:8888
      username: config-user
      password: config-password
      fail-fast: true
      retry:
        initial-interval: 1000
        max-attempts: 6
        max-interval: 2000
        multiplier: 1.1
      request-connect-timeout: 5000
      request-read-timeout: 5000
      tls:
        enabled: true
        key-store: classpath:client-keystore.p12
        key-store-password: changeit
        key-store-type: PKCS12
        trust-store: classpath:client-truststore.p12
        trust-store-password: changeit
        trust-store-type: PKCS12

management:
  endpoints:
    web:
      exposure:
        include: refresh,health,info
  endpoint:
    refresh:
      enabled: true

logging:
  level:
    org.springframework.cloud.config: DEBUG
    org.springframework.web.client: DEBUG
```

### 3. SSL Certificate Setup for Client

Place your client SSL certificates in `src/main/resources/`:
- `client-keystore.p12` - Client's private key and certificate
- `client-truststore.p12` - Trusted server certificates (including config server certificate)

### 4. Enable Configuration Refresh

Add the `@RefreshScope` annotation to any beans that should be refreshed when configuration changes:

```java
@RestController
@RefreshScope
public class ConfigurationController {
    
    @Value("${app.message:Default Message}")
    private String message;
    
    @GetMapping("/message")
    public String getMessage() {
        return message;
    }
}
```

## Configuration File Mapping and Hosting

### 1. Configuration File Naming Convention

The Config Server serves configuration files based on the following naming pattern:

```
/{application}/{profile}[/{label}]
/{application}-{profile}.yml
/{label}/{application}-{profile}.yml
/{application}-{profile}.properties
/{label}/{application}-{profile}.properties
```

Where:
- `{application}` maps to `spring.application.name` on the client
- `{profile}` maps to `spring.profiles.active` on the client
- `{label}` is a server-side feature for versioning (optional)

### 2. Example Configuration Files

#### `config-repo/application.yml` (Global Default Configuration)
```yaml
# Default configuration applied to all applications
logging:
  level:
    root: INFO

management:
  endpoints:
    web:
      exposure:
        include: health,info
```

#### `config-repo/client-app.yml` (Application-Specific Configuration)
```yaml
app:
  name: Client Application
  version: 1.0.0
  message: Hello from Config Server!

database:
  url: jdbc:h2:mem:testdb
  username: sa
  password: ""
```

#### `config-repo/client-app-dev.yml` (Development Profile)
```yaml
app:
  message: Hello from Config Server - Development Environment!

database:
  url: jdbc:h2:mem:devdb
  
logging:
  level:
    com.yourpackage: DEBUG
```

#### `config-repo/client-app-prod.yml` (Production Profile)
```yaml
app:
  message: Hello from Config Server - Production Environment!

database:
  url: jdbc:postgresql://prod-db:5432/proddb
  username: ${DB_USERNAME}
  password: ${DB_PASSWORD}

logging:
  level:
    com.yourpackage: WARN
```

### 3. Configuration Priority

Configuration properties are resolved in the following order (highest to lowest priority):

1. `{application}-{profile}.yml`
2. `{application}.yml`
3. `application-{profile}.yml`
4. `application.yml`

### 4. Accessing Configuration Endpoints

Once both server and client are running, you can access configurations via:

- **Server endpoints:**
  - `https://localhost:8888/client-app/dev` - JSON format
  - `https://localhost:8888/client-app/dev/main` - With label
  - `https://localhost:8888/client-app-dev.yml` - YAML format

- **Client endpoints:**
  - `https://localhost:8080/actuator/health` - Health check
  - `https://localhost:8080/actuator/refresh` - Refresh configuration (POST)

## SSL Certificate Generation (Optional)

If you need to generate self-signed certificates for testing:

### Generate Server Certificate
```bash
# Generate server keystore
keytool -genkeypair -alias config-server -keyalg RSA -keysize 2048 \
  -storetype PKCS12 -keystore keystore.p12 -validity 365 \
  -dname "CN=localhost,OU=IT,O=YourOrg,L=YourCity,ST=YourState,C=US"

# Export server certificate
keytool -export -alias config-server -keystore keystore.p12 \
  -rfc -file config-server.crt
```

### Generate Client Certificate
```bash
# Generate client keystore
keytool -genkeypair -alias config-client -keyalg RSA -keysize 2048 \
  -storetype PKCS12 -keystore client-keystore.p12 -validity 365 \
  -dname "CN=config-client,OU=IT,O=YourOrg,L=YourCity,ST=YourState,C=US"

# Export client certificate
keytool -export -alias config-client -keystore client-keystore.p12 \
  -rfc -file config-client.crt
```

### Create Trust Stores
```bash
# Server truststore (import client cert)
keytool -import -alias config-client -file config-client.crt \
  -keystore truststore.p12 -storetype PKCS12

# Client truststore (import server cert)
keytool -import -alias config-server -file config-server.crt \
  -keystore client-truststore.p12 -storetype PKCS12
```

## Testing the Setup

1. Start the Config Server: `mvn spring-boot:run`
2. Verify server is running: `https://localhost:8888/actuator/health`
3. Start the Config Client: `mvn spring-boot:run`
4. Test configuration retrieval: `https://localhost:8080/message`
5. Test configuration refresh: 
   - Modify a configuration file
   - POST to `https://localhost:8080/actuator/refresh`
   - Verify changes are applied

## Troubleshooting

### Common SSL Issues
- Ensure certificates are properly imported in trust stores
- Verify certificate aliases match configuration
- Check certificate validity dates
- Ensure proper certificate chain

### Connection Issues
- Verify network connectivity between client and server
- Check firewall settings
- Validate SSL handshake with openssl or similar tools
- Review application logs for detailed error messages

### Configuration Issues
- Ensure application names match between client and server
- Verify profile names are correct
- Check file naming conventions in config repository
- Validate YAML syntax in configuration files