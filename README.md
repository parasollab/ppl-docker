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

### 2.1. Create your SSH key
```sh
make-ssh-key {your-email-address}
```

### 2.2 Add your SSH key to Github and allow Parasollab permissions
See [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) for instructions. \

Be sure to click the "Configure SSO" dropdown and allow parasollab to access the new key. 

### 2.3 Clone HASRRT's branch of PPL. 
```sh
clone-hasrrt
```

### 3. Build PPL inside container - just the HASRRT branch
(if this step results in an error, try running #4 first and coming back to this)
```sh
cd ~/ppl_ws/hasrrt-ppl
build-ppl-conan hasrrt-ppl
```

**There are now 2 versions of ppl: one in the folder called "ppl" and the other in the folder called "hasrrt-ppl". This is an unfortunate necessity. hasrrt-ppl is the only branch that has HAS-RRT, and ppl is the only branch that will work with vizmo. **

### 4. Build Vizmo inside container

```sh
goppl
build-ppl-conan ppl
build-vizmo
(there might be a bug.. unsure. )
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

### 6. Run the HASRRT experiments 
```sh
navigate to the hasrrt-experiments folder (repo was cloned when running clone-hasrrt)
Follow the setup instructions here: https://github.com/parasollab/hasrrt-experiments/tree/sp25.
Your ppl executable should be called ppl_mp and should be in the hasrrt-ppl/build folder. 

Use ./ppl_mp -f SimplePassage.xml to run an experiment.
```

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
