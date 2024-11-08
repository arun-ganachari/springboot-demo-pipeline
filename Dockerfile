# Stage 1: Build the application
FROM maven:3.9.3 AS builder

# Set the working directory in the container
WORKDIR /app

# Copy the Maven Wrapper and project files
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Copy the entire source code into the container
COPY src ./src

# Give executable permissions to mvnw
RUN chmod +x mvnw

# Build the application using the Maven Wrapper
RUN ./mvnw clean package

# Stage 2: Create the final image
FROM openjdk:17-jdk

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the builder stage into the final image
COPY --from=builder /app/target/*.jar app.jar

# Expose the port on which the application will run
EXPOSE 8090

# Command to run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]

