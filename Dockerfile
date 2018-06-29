FROM openjdk:8-jdk-alpine
MAINTAINER Juan Sotomayor "jsoto128@fiu.edu"
VOLUME /tmp
ADD build/libs/discoveryservice-0.0.1.jar app.jar
ENV JAVA_OPTS=""
EXPOSE "8761:8761"
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
