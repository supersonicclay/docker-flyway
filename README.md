# Flyway Docker

Docker container for [flyway](https://flywaydb.org/) command line.


Workaround until this issue is merged:
https://github.com/flyway/flyway/issues/797


## Getting started

`docker run claycephas/flyway [flyway cli arguments here]`

## Example

Add a file named `V1__Initial.sql` with following contents:
```
CREATE TABLE MyTable (
    MyColumn VARCHAR(100) NOT NULL
);

```

### Linux
`docker run --rm -v $(pwd):/dbscripts claycephas/flyway -url=jdbc:mysql/mydb -schemas=myschema -user=root -password=P@ssw0rd -locations=filesystem:/dbscripts migrate`

### Windows 10 (Docker for Windows)
CMD:

`docker run --rm -v %cd%:/dbscripts claycephas/flyway -url=jdbc:mysql/mydbhost -schemas=myschema -user=root -password=P@ssw0rd -locations=filesystem:/dbscripts migrate`

PowerShell:

`docker run --rm -v C:\FolderWhereYourScriptsReside:/dbscripts claycephas/flyway -url=jdbc:mysql/mydbhost -schemas=myschema -user=root -password=P@ssw0rd -locations=filesystem:/dbscripts migrate`

### Windows 7 (Docker Toolbox)

`docker run --rm -v /c/Users/FolderWhereYourScriptsReside:/dbscripts claycephas/flyway -url=jdbc:mysql/mydbhost -schemas=myschema -user=root -password=P@ssw0rd -locations=filesystem:/dbscripts migrate`


### Example docker-compose.yml

A compose file that will setup a database container and a container to perform migrations.

```
version: '2'
services:
  schema:
    image: claycephas/flyway
    command: -url=jdbc:mysql://db -schemas=myschema -user=root -password=P@ssw0rd -locations=filesystem:/dbscripts migrate
    volumes:
      - .:/dbscripts
    depends_on:
      - db
  db:
    image: mysql
    environment:
      - MYSQL_ROOT_PASSWORD=P@ssw0rd
    command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
    ports:
      - 3306:3306
```

Run `docker-compose up -d db`, wait a minute for MySQL to be initialized then run `docker-compose up schema`.


