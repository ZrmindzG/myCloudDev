FROM tomcat:9.0.52-jre11-openjdk-slim as build
COPY build/target/makemytrip*.jar /usr/local/tomcat/webapps
EXPOSE 8080
USER makemytrip
WORKDIR build/usr/local/tomcat/webapps
CMD  ["catalina.sh","run"]
