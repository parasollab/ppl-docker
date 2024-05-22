#!/bin/bash

# Build the vcpkg dependencies.

apt-get update

cd /root/ppl_ws/ppl

cmake -B build -S . -G Ninja -DCMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Debug
