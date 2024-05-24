# PPL Docker Environment (Ubuntu 20.04)

Packages PPL (Release-stage-two) and Vizmo in a Docker container.

## Instructions

### Install Docker Desktop

If you don't have Docker Desktop installed, download and install it using [this link](https://docs.docker.com/engine/install/). Then, open the Docker application.

#### Apple Silicon

If you have a mac with an apple silicon processor (e.g. M1 chips or later), open the settings in the Docker app and check to make sure that the option for **Use Rosetta for x86_64/amd64 emulation on Apple Silicon** is enabled. Additionally, install [XQuartz](https://www.xquartz.org/) and in the XQuartz settings, make sure that **Allow connections from network clients** is enabled.

### 1. Build docker image

```sh
./BUILD-DOCKER-IMAGE.sh
```

> If you get issues related to the docker daemon, try [this](https://medium.com/@praveenadoni4456/error-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket-at-e68bfab8146a).

### 2. Create and run docker container

```sh
./RUN-DOCKER-CONTAINER.sh
```

### 3. Build PPL inside container

```sh
build-ppl-conan
```

### 4. Build Vizmo inside container

```sh
build-vizmo
```

### 5. Test to see if everything build properly

```sh
goppl
```

```sh
./build/ppl_mp -f Examples/CfgExamples.xml
```

```sh
goviz
```

```sh
./vizmo++
```

TODO

## Stop docker container

To stop the docker container run:

```sh
docker stop $USER-ppl-1
```

## Deleting Containers

To delete all docker containers (docker cache) run:

```sh
docker system prune -a
```
