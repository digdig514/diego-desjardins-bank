FROM maven:3.8.5-eclipse-temurin-17-alpine as build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD pom.xml $HOME
RUN mvn verify --fail-never
ADD . $HOME
RUN mvn package -DskipTests

FROM openjdk:17-alpine 
COPY --from=build /usr/app/target/*.jar /app/runner.jar
ENTRYPOINT java -jar /app/runner.jar
