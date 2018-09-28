# httpd
Apache with some basic configuration

## Introduction
This project aims to fulfill two needs:
1. Create HTTP server that is deployable on a scalable infrastructure.
2. create a useable [Docker](https://www.docker.com) base image.

## What will it do
It will create an Apache application that can host static webpages.

## Components
This stack is composed of the following:
* [Apache HTTPD](http://httpd.apache.org)

### Build
```
docker build -t pdok/httpd .
```

### Run
This image can be run straight from the commandline.
```
docker run -d -p 80:80 --name httpd pdok/httpd
```
The prefered way to use it is as a Docker base image for an other Dockerfile, in which the necessay files are copied into the right directory (/var/www/html/)
```
FROM pdok/httpd

COPY /index.html /var/www/
```
Running the example above will create a service on the url: http:/localhost/
