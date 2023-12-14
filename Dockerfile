FROM tomcat:latest
WORKDIR .Workspace/makemytrip
COPY ./target/makemytrip*.jar .
EXPOSE 8080
CMD ["java", "-jar", "makemytrip*.jar"]
