# Stage 1: Build the artifact
FROM maven:3.8.4-openjdk-17-slim AS builder

WORKDIR /app

# Copy the Maven project files and download dependencies
COPY pom.xml .
COPY src ./src

# Build the artifact
RUN mvn clean package

# Stage 2: Create the final image with Java 8 and the built artifact
FROM openjdk:17-slim

WORKDIR /code

# Copy the artifact from the builder stage to the final image
COPY --from=builder /app/target/*.jar /code/

# Set the CMD to run the Java application
CMD ["java", "-jar", "/code/your-artifact.jar"]