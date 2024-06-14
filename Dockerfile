# Usar la imagen base de Clojure con Leiningen
FROM clojure:lein-2.10.0 as builder

# Establecer el directorio de trabajo
WORKDIR /opt/service

# Copiar el archivo de configuración del proyecto
COPY project.clj /opt/service/

# Instalar las dependencias del proyecto
RUN lein deps

# Copiar todos los archivos del proyecto
COPY . /opt/service/

# Ejecutar el proyecto
RUN lein uberjar

# Listar archivos en el directorio de destino para verificar el nombre del archivo JAR
RUN ls /opt/service/target/uberjar/

FROM openjdk:17 as runtime
COPY --from=builder /opt/service/target/uberjar/dockerize-0.1.0-SNAPSHOT-standalone.jar /opt/service/dockerize-0.1.0-SNAPSHOT-standalone.jar

CMD ["java", "-jar", "/opt/service/dockerize-0.1.0-SNAPSHOT-standalone.jar"]
