#!/bin/bash

set -e

mkdir -p /build
cd /build

python3.7 -m pip install numpy

cmake -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_ASAP:BOOL=ON \
    -DBUILD_EXECUTABLES:BOOL=ON \
    -DBUILD_IMAGEPROCESSING:BOOL=ON \
    -DBUILD_MULTIRESOLUTIONIMAGEINTERFACE_VSI_SUPPORT:BOOL=ON \
    -DWRAP_WHOLESLIDEFILTERS_PYTHON=ON \
    -DWRAP_MULTIRESOLUTIONIMAGEINTERFACE_PYTHON=ON \
    /src

cpu_count=$(cat /proc/cpuinfo  | grep ^processor | wc -l)
nice make -j$cpu_count
