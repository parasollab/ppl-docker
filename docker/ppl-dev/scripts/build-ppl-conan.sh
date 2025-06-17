#!/bin/bash

# Download package lists from Ubuntu repositories.
apt-get update

#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 PPL_FOLDER"
    exit 1
fi

PPLFOLDER=$1
cd /root/ppl_ws/${PPLFOLDER}


conan install . --output-folder=build --profile:build=default -c tools.system.package_manager:mode=install  -c tools.build:jobs=8  -s compiler.cppstd=gnu17 -s build_type=Debug --build missing  -g CMakeDeps  -g CMakeToolchain \

# Change the CMAKE policy version in lib/PQP/CMakeLists.txt (OLD doesn't work with newest CMake...)
sed -i -e 's/cmake_policy(SET CMP0048 OLD)/cmake_policy(SET CMP0048 NEW)/g' lib/PQP/CMakeLists.txt

#Build pmpl executable
cmake -B build -S . -G  Ninja -DCMAKE_TOOLCHAIN_FILE=build/conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Debug -DCODE_COVERAGE=OFF -DBUILD_DOCS=OFF -DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build build -- -j 4