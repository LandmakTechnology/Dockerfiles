FROM ubuntu
RUN echo "Run One Updated"
RUN echo "RUN TWO"
RUN echo "RUN Three"
CMD date
ENTRYPOINT [ "echo", "hello" ]


#git
FROM alpine/git as repo

MAINTAINER name mylandmarktech@gmail.com

WORKDIR /app
RUN git clone https://github.com/LandmakTechnology/maven-web-app.git

#Maven
FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=repo /app/maven-web-app  /app 
RUN mvn install

#Tomcat
FROM tomcat:8.0.20-jre8
COPY --from=build /app/target/maven-web-app*.war /usr/local/tomcat/webapps/maven-web-app.war


