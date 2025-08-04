# PPL Docker Environment (Ubuntu 20.04)

Packages PPL (Release-stage-two) and Vizmo in a Docker container.

## Instructions

### Install Docker Desktop

If you don't have Docker Desktop installed, download and install it using [this link](https://docs.docker.com/engine/install/). Then, open the Docker application.

#### Apple Silicon

If you have a mac with an apple silicon processor (e.g. M1 chips or later), open the settings in the Docker app and check to make sure that the option for **Use Rosetta for x86_64/amd64 emulation on Apple Silicon** is enabled. Additionally, install [XQuartz](https://www.xquartz.org/) and in the XQuartz settings, make sure that **Allow connections from network clients** is enabled.

### 1. Build docker image (~1 hour)

```sh
./BUILD-DOCKER-IMAGE.sh
```

> If you get issues related to the docker daemon, try [this](https://medium.com/@praveenadoni4456/error-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket-at-e68bfab8146a).

If the build fails on step 34 or 35 (`cmake -B build -S . -G  Ninja ...` or `cmake --build build` ) with error "cannot allocate memory", comment out lines 135 and 136 of `docker/ppl-dev/Dockerfile`, re-attempt to build the docker image, and compile PPL using the instructions below after the next step. 

### 2. Create and run docker container

```sh
./RUN-DOCKER-CONTAINER.sh
```



### 4. Test to see if everything build properly

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


### If editing source files, build PPL and Vizmo inside container

```sh
goppl
build-ppl-conan ppl # build PPL inside container 

goviz
build-vizmo # build Vizmo inside container
```

If `build-ppl-conan ppl` fails, execute line-by-line from line 17 onwards of [this](https://github.com/parasollab/ppl-docker/blob/vizmo-only/docker/ppl-dev/scripts/build-ppl-conan.sh). Follow the failure instructions in the comments, depending on what the issue was. 

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
