FROM ubuntu:20.04

# Avoid user interaction during install of tzdata
# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ENV TZ=US
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

################################################################################

#Installs prerequisites for pmpl
RUN  apt-get update \
    && apt-get -y upgrade \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        tzdata \
        build-essential gdb \
        python gperf libclang-dev \
        gfortran \
        ninja-build \
        pkg-config \
        make wget curl zip unzip \
        software-properties-common \
        git-all \
        libtool \
        autoconf-archive \
        texinfo \
        bison \
        libmpfr-dev libfontenc-dev libxaw7-dev\
        libeigen3-dev \
        libboost-all-dev \
        libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev \
        libxft-dev libfontconfig1-dev libfreetype6-dev libx11-dev libx11-xcb-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev \
        libxcb1-dev libxcb-glx0-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync-dev \
        libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev libxcb-util-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libatspi2.0-dev \
        libxrandr-dev libxcursor-dev libxdamage-dev libxinerama1 libxinerama-dev \
        libssl-dev libglu1-mesa-dev libgl1-mesa-dev mesa-common-dev \
        doxygen graphviz lcov gcovr \
        && rm -rf /var/lib/apt/lists/*

# Install optional packages/tools.
RUN apt-get update && apt-get install -y --no-install-recommends \
    inetutils-ping \
    iproute2 \
    gdb \
    mesa-utils \
    nano \
    net-tools \
    openssh-client \
    unzip \
    vim \
    less \
    usbutils \
    && rm -rf /var/lib/apt/lists/*
        
# install latest cmake > 3.24
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null \ 
    && echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null
RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main'
RUN apt update
RUN apt-get -y install cmake

#download and build vcpkg
RUN mkdir -p /opt \
    && git clone https://github.com/Microsoft/vcpkg.git /opt/vcpkg \
    && chmod 777 /opt/vcpkg
WORKDIR /opt/vcpkg
RUN ./bootstrap-vcpkg.sh \
    && chmod 666 .vcpkg-root

#Copy source code from host system
RUN mkdir -p /root/ppl_ws
# COPY . /root/ppl_ws
RUN git clone https://github.com/parasollab/open-ppl.git ppl

# Install qt4
RUN add-apt-repository -y ppa:rock-core/qt4
RUN apt-get update && apt-get install -y --no-install-recommends \
    qt4-default \
    qt4* \
    libqt4-opengl \
    libqt4-opengl-dev


# Clone open-ppl-utils
WORKDIR /root/ppl_ws
RUN git clone https://github.com/parasollab/open-ppl-utils.git pmpl_utils

# Clone Vizmo
RUN git clone https://github.com/parasollab/vizmo.git -b ubuntu-20-04 vizmo

# Clone Vizmo PPL package
WORKDIR /root/ppl_ws/vizmo
RUN git clone https://github.com/parasollab/open-ppl.git --depth 1 --branch vizmo pmpl

# Setup soflinks
WORKDIR /root/ppl_ws/vizmo/pmpl
RUN ln -s /root/ppl_ws/pmpl_utils

# Copy the helper scripts to the working directory.
WORKDIR /root/ppl_ws
COPY ./docker/ppl-dev/scripts/. /root/ppl_ws/docker/ppl-dev/scripts/
RUN chmod -R +x /root/ppl_ws/docker/ppl-dev/scripts/*

# Setup the Bash shell environment with '/root/.bashrc'.
RUN echo "source /root/ppl_ws/docker/ppl-dev/scripts/initialize-bash-shell.sh" >> /root/.bashrc

# Force color prompt in terminal.
RUN sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /root/.bashrc

#Build ppl executables
WORKDIR /root/ppl_ws/ppl
# RUN cmake -B build -S . -G Ninja -DCMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Debug
# RUN cmake --build build

# Build vizmo executable
# WORKDIR /root/ppl_ws/vizmo/src
# RUN make -j4

# Overwrite the entry point of the parent image.
ENTRYPOINT []

# Enter the container with a Bash shell.
CMD ["/bin/bash"]
