# Start from official Java image
FROM registry1.dso.mil/ironbank/redhat/openjdk/openjdk17-slim:1.17

# Add a volume to hold the app
VOLUME /tmp

# Set the working directory
WORKDIR /app

# Copy built jar into image
COPY target/secure-config-server-0.0.1.jar app.jar

# Run the app
ENTRYPOINT ["java","-jar","/app/app.jar"]
