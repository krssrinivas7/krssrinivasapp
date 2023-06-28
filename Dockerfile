FROM tomcat:8.0.20-jre8
COPY target/KRS-maven-web-app*.war /usr/local/tomcat/webapps/KRS-maven-web-app.war
