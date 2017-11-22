# GI-Sync-Docker Repository
===========================

## Dockerfile

The file contains the extension of image webdevops/php-apache-dev:7.1 to integrate libyaml and yaml PECL extension module.

## Dev envinroment setup

### MySQL server
```
docker run -d \
-it \
--name wp-mysql \
-h mysql.dev \
-p 3306:3306 \
-e "MYSQL_ROOT_PASSWORD=supersecretpassword" \
--mount type=bind,source=${HOME}/workspace/gi-sync/wp-mysql-data,target=/var/lib/mysql \
mysql:latest
```

### DB Initialization

Log into MySQL container

```
CREATE DATABASE wptest1;

CREATE USER 'zerrossetto'@'localhost' IDENTIFIED BY 'good-old-password';
GRANT ALL PRIVILEGES ON * . * TO 'zerrossetto'@'localhost';
CREATE USER 'zerrossetto'@'%' IDENTIFIED BY 'good-old-password';
GRANT ALL PRIVILEGES ON * . * TO 'zerrossetto'@'%';


CREATE USER 'wptest1_tu'@'localhost' IDENTIFIED BY 'gibberish-password';
GRANT ALL PRIVILEGES ON wptest1.* TO 'wptest1_tu'@'localhost';
CREATE USER 'wptest1_tu'@'%' IDENTIFIED BY 'gibberish-password';
GRANT ALL PRIVILEGES ON wptest1.* TO 'wptest1_tu'@'%';

FLUSH PRIVILEGES;
```

### Apache server configuration

docker run -d \
-it \
--name wp-apache-php \
-h apache24.dev \
-p 8080:80 \
-p 8443:443 \
-p 9000:9000 \
--link wp-mysql:mysql.dev \
-e "php.display_errors=On" \
--mount type=bind,source=${HOME}/workspace/gi-sync/wp-apache-php/htdocs,target=/app \
zerrossetto/php-apache-dev-yaml:7.1

