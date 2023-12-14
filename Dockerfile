FROM tomcat:latest
WORKDIR /usr/local/tomcat/webapps
COPY target/makemytrip*.jar .
EXPOSE 8080
CMD ["java", "-jar", "makemytrip*.jar"]
