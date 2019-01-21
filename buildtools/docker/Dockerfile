FROM ubuntu:18.04

RUN apt-get update

# === Setup user ===
RUN useradd -ms /bin/bash user && (echo user ; echo user) | passwd user

# === Setup sudo ===
RUN apt-get install -y sudo && gpasswd -a user sudo

# === Install useful extra libs ===
RUN apt-get install -y git nano tmux
RUN apt-get install -y wget xz-utils

# === Install python 3.6(!!!) ===
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev \
        libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev gcovr libffi-dev uuid-dev

RUN cd /tmp && \
    wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tar.xz && \
    tar xfv Python*.xz && \
    cd Python-3*/ && \
    ./configure --enable-shared LDFLAGS="-fprofile-arcs" && \
    make -j16 install && \
    cd /tmp && \
    rm -rf Python-3*
RUN ldconfig -v

RUN apt-get install -y cmake
RUN apt-get install -y qt5-default qttools5-dev

RUN apt-get install -y libboost-all-dev libopenjp2-7-dev libtiff-dev libdcmtk-dev

# Slip parallel installing of opencv in here ... a bit messy but way faster
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y libopencv-dev & \
    mkdir /tmp/pugixml && cd /tmp/pugixml \
        && wget https://github.com/zeux/pugixml/releases/download/v1.9/pugixml-1.9.tar.gz \
        && tar xfv pugixml*.tar.gz \
        && cd pugixml-1.9 \
        && mkdir build && cd build \
        && cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON .. \
        && make -j16 && make install \
        && cd /tmp && rm -rf pugixml && \
    wait

RUN apt-get install -y autoconf libcairo-dev libgdk-pixbuf2.0-dev libxml2-dev
RUN mkdir /tmp/openslide && cd /tmp/openslide \
        && git clone https://github.com/openslide/openslide.git \
        && cd openslide \
        && git checkout v3.4.1 \
        && autoreconf -i && ./configure \
        && make -j16 && make install \
        && cd /tmp && rm -rf openslide
