#!/bin/bash

# Download package lists from Ubuntu repositories.
apt-get update

cd /root/ppl_ws/vizmo/src

# clone the correct ppl branch
cd /root/ppl_ws/vizmo
git clone https://github.com/parasollab/open-ppl.git --depth 1 --branch ubuntu-20-04-vizmo ppl

# fix versioning issues
cd ../pmpl_utils
fix-cmake-versions
cd ../src


make -j4