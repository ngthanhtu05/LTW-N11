FROM maven:3.8.4-openjdk-17 as build

WORKDIR /lazy247/spring-mvc
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk


RUN rm -rf /usr/local/tomcat/webapps/*


COPY --from=build /lazy247/spring-mvc/target/*.war /lazy247/spring-mvc/app.war

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "/lazy247/spring-mvc/app.war" ]
