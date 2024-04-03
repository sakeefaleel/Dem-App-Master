FROM maven:3.8.3-openjdk-17 as builder
RUN mkdir -p /app/source
COPY . /app/source
WORKDIR /app/source
RUN mvn clean package
RUN ls -l /app/source/
RUN ls -l /app/source/target/



FROM openjdk:17-jdk-alpine as runtime
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]