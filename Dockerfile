FROM maven:3.9.0-eclipse-temurin-19-focal as build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN mvn -version
RUN mvn package -Dmaven.test.skip
RUN echo $JAVA_HOME
FROM eclipse-temurin:19-jre-alpine
COPY --from=build /usr/app/target/rest-service-0.0.1-SNAPSHOT.jar /app/rest-service-0.0.1-SNAPSHOT.jar

# Set a non-root user
USER 10014
EXPOSE 8080
ENTRYPOINT java -jar /app/rest-service-0.0.1-SNAPSHOT.jar

