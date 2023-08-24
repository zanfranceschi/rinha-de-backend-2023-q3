FROM ubuntu:latest as BUILD

# Install Oracle OpenJDK 21
RUN apt -y update && apt -y upgrade && apt -y install wget
RUN wget https://download.java.net/java/GA/jdk21/fd2272bbf8e04c3dbaee13770090416c/35/GPL/openjdk-21_linux-x64_bin.tar.gz
RUN tar zxvf openjdk-21_linux-x64_bin.tar.gz
ENV JAVA_HOME=/jdk-21
ENV PATH="$JAVA_HOME/bin:${PATH}"

WORKDIR /app

COPY src /app/src
COPY pom.xml /app
COPY .mvn /app/.mvn
COPY mvnw /app/mvnw

RUN ./mvnw clean package -DskipTests

FROM ubuntu:latest as RUNTIME

COPY --from=BUILD /app/target/rinhabackend2023-0.0.1-SNAPSHOT.jar /rinha.jar
COPY --from=BUILD /jdk-21 /jdk-21

ENV JAVA_HOME=/jdk-21
ENV PATH="$JAVA_HOME/bin:${PATH}"

EXPOSE 8080


ENTRYPOINT [ "java", "-XX:+UseParallelGC", "-XX:MaxRAMPercentage=75", "--enable-preview", "-jar", "./rinha.jar" ]
