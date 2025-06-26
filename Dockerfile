FROM eclipse-temurin:17-jre
WORKDIR /app
COPY app.jar .
EXPOSE 8081
CMD ["java", "-jar", "app.jar"]

