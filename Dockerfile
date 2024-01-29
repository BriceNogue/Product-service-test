# syntax=docker/dockerfile:1

#FROM eclipse-temurin:17-jdk-jammy

#WORKDIR /app

#COPY .mvn/ .mvn
#COPY mvnw pom.xml ./

#RUN ./mvnw dependency:resolve

#COPY src ./src

#CMD ["./mvnw", "spring-boot:run"]



FROM maven:3.8.4-openjdk-17-slim AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn package -DskipTests

#FROM adoptopenjdk/openjdk17:jre-17.0.0_35_ubuntu
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]