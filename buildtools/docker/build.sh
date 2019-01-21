#!/bin/bash

set -e

mkdir -p /build
cd /build

cmake -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_ASAP:BOOL=ON \
    -DBUILD_EXECUTABLES:BOOL=ON \
    -DBUILD_IMAGEPROCESSING:BOOL=ON \
    -DBUILD_MULTIRESOLUTIONIMAGEINTERFACE_VSI_SUPPORT:BOOL=ON \
    /src

cpu_count=$(cat /proc/cpuinfo  | grep ^processor | wc -l)
nice make -j$cpu_count
