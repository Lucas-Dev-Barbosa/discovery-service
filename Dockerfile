FROM maven:3.8.6-jdk-8 as build

WORKDIR /discovery-service

COPY /src ./src
COPY pom.xml .
COPY Dockerfile .

RUN mvn -f . clean install -DskipTests

FROM amazoncorretto:8

COPY --from=build /discovery-service/target/*.jar app.jar
ENTRYPOINT [ "java", "-jar", "/app.jar" ]

EXPOSE 8761