#!/bin/bash

# Download package lists from Ubuntu repositories.
apt-get update

cd /root/ppl_ws/ppl

conan install . --output-folder=build --profile:build=default -c tools.system.package_manager:mode=install -s compiler.cppstd=gnu17 -s build_type=Debug --build missing

#Build pmpl executable
cmake -B build -S . -G  Ninja -DCMAKE_TOOLCHAIN_FILE=build/conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Debug
cmake --build build -- -j 4