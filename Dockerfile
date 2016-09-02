FROM openjdk:8

RUN wget -O /flyway.tar.gz https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/4.0.3/flyway-commandline-4.0.3.tar.gz

RUN tar -xzf /flyway.tar.gz && rm /flyway.tar.gz && mv /flyway-4.0.3 /flyway

WORKDIR /flyway
ENTRYPOINT /flyway/flyway
CMD ["--help"]"
