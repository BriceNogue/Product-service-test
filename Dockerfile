#****************** Configuration de base pour spring boot *********************************#
# syntax=docker/dockerfile:1

#FROM eclipse-temurin:17-jdk-jammy

#WORKDIR /app

#COPY .mvn/ .mvn
#COPY mvnw pom.xml ./

#RUN ./mvnw dependency:resolve

#COPY src ./src

#CMD ["./mvnw", "spring-boot:run"]


# Étape de test
# Instructions pour la construction et l'exécution des tests
#FROM maven:3.8.4-openjdk-17-slim AS build #A utiliser lorsqu'on a une classe principale main
FROM maven:3.8.4-openjdk-17-slim AS test

WORKDIR /app

COPY pom.xml .
COPY src ./src

COPY src/test/java ./src/test/java

#A utiliser lorsqu'on a une classe principale main
#RUN mvn package -DskipTests
#A ne utiliser lorsqu'on a une classe principale main
RUN mvn test

#FROM adoptopenjdk/openjdk17:jre-17.0.0_35_ubuntu
#FROM eclipse-temurin:17-jdk-jammy #A utiliser lorsqu'on a une classe principale main

#WORKDIR /app #A utiliser lorsqu'on a une classe principale main

#COPY --from=build /app/target/*.jar app.jar #A utiliser lorsqu'on a une classe principale main

#CMD ["java", "-jar", "app.jar"] #A utiliser lorsqu'on a une classe principale main

FROM maven:3.8.4-openjdk-17-slim AS production

WORKDIR /app

COPY pom.xml .
COPY src ./src

COPY src/test/java ./src/test/java

RUN mvn test