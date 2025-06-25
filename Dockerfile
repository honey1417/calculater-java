# ---------- Stage 1: Builder ----------
# Use a full JDK image for downloading and preparing the JAR
FROM eclipse-temurin:17-jdk as builder

# Create a working directory
WORKDIR /app

# Set build-time environment variables for Nexus credentials
ARG NEXUS_USERNAME
ARG NEXUS_PASSWD

# Download the latest snapshot JAR from Nexus using curl with credentials
RUN curl -u ${NEXUS_USERNAME}:${NEXUS_PASSWORD} \
  -o app.jar \
  "http://34.10.114.146:8081/repository/maven-artifacts-snapshots-repo/com/example/calculator/0.0.1-SNAPSHOT/calculator-0.0.1-SNAPSHOT.jar"

# ---------- Stage 2: Final Image ----------
# Use a lightweight JRE image to run the application
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /app

# Copy the downloaded JAR from the builder stage to this stage
COPY --from=builder /app/app.jar .

# Expose the application port (if required)
EXPOSE 8081

# Command to run the Spring Boot application
CMD ["java", "-jar", "app.jar"]
