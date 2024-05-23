#!/bin/bash

# Download package lists from Ubuntu repositories.
apt-get update

cd /root/ppl_ws/ppl

cmake -B build -S . -G Ninja -DCMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Debug

cmake --build build -- -j 4