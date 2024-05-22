# PPL Docker Environment (Ubuntu 20.04)
Packages PPL (Release-stage-two) and Vizmo in a Docker container.

## Instructions
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
build-ppl
```

### 4. Build Vizmo inside container

```sh
build-vizmo
```

