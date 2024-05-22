#!/bin/bash

# Download package lists from Ubuntu repositories.
apt-get update

cd /root/ppl_ws/ppl

cmake --build build -- -j 4