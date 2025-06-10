# Start from official Java image
FROM registry1.dso.mil/ironbank/redhat/openjdk/openjdk17-slim:1.17

# Add a volume to hold the app
VOLUME /tmp

# Set the working directory
WORKDIR /app

# Copy built jar into image
COPY target/secure-test-0.0.1.jar /app/app.jar
COPY src/main/resources/configserver.p12 /app/configserver.p12

# Run the app
ENTRYPOINT ["java", "-Djavax.net.debug=ssl,handshake,trustmanager", "-Djavax.net.ssl.trustStore=/app/configserver.p12", "-Djavax.net.ssl.trustStorePassword=password", "-Djavax.net.ssl.trustStoreType=PKCS12",  "-jar","/app/app.jar"]
