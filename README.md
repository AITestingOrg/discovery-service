# Discovery Service
[![Build Status](https://travis-ci.org/AITestingOrg/discovery-service.svg?branch=master)](https://travis-ci.org/AITestingOrg/discovery-service)

This Service is a personilzed implementation of Eureka and acts as a discovery hub for any microservice that sends its registration signature.


## Features

  - Register microservices
  - Send updated information about the registered microservices

## Open source being used

The Configuration Service uses a number of open source projects to work properly:

* [Spring Framework]
* [OpenJDK]
* [Eureka]
* [Gradle]
* [Docker]

## Running the service
The Configuration Service requires [Docker] v18+ to run.

Once Docker is installed you can build from source or use the predefined images available at [Docker Hub](https://hub.docker.com/u/aista/dashboard/)

### Building from source
Using gradle wrapper:
```sh
cd discovery-service
./gradlew clean build
docker-compose -f docker-compose-local.yml up --build
```
This will build the application and generate the jar file to be placed in a container and also run a personalized version of Eureka called discovery-service.

### Using Docker Hub images
The Configuration Service is very easy to run from the images on Docker Hub.

By default, Docker will expose port 8888. You can change this within the docker-compose.yml file if necessary.

```sh
cd configuration-service
docker-compose up
```

## Client configuration

In order for the Java Spring client applications register themselves in the discovery service, they need to have the following configurations in Application.java, application.yml and gradle.build.
##### Application.java
The `@EnableEurekaClient` annotation must be present in the main Application.java.
```java
...
@EnableEurekaClient
public class Application {
...
```
##### application.yml
The application.yml file needs to be configured as instructed below:

```yml
eureka:
  instance:
    preferIpAddress: true
  client:
    registerWithEureka: true
    fetchRegistry: true
    serviceUrl:
        defaultZone: http://${DOCKER_MACHINE_IP:discoveryservice}:8761/eureka/
```
##### build.gradle
The build.gradle file must contain the next configuration:
```gradle
ext {
    springCloudVersion = 'Edgware.SR2'
}
...
dependencies {
...
    compile('org.springframework.cloud:spring-cloud-starter-eureka')
...
}
...
dependencyManagement {
	imports {
		mavenBom "org.springframework.cloud:spring-cloud-dependencies:${springCloudVersion}"
	}
}
```

[//]: # (Reference links)

   [Spring Framework]: <https://spring.io/>
   [OpenJDK]: <http://openjdk.java.net/>
   [Eureka]: <https://github.com/Netflix/eureka>
   [Gradle]: <https://gradle.org/>
   [Docker]: <https://www.docker.com/>