FROM docker.io/ubuntu:26.04

# Install dependencies
RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirror.math.princeton.edu/pub/ubuntu/|g' /etc/apt/sources.list
RUN sed -i 's|http://archive.ubuntu.com/ubuntu|http://mirror.math.princeton.edu/pub/ubuntu|g' /etc/apt/sources.list.d/ubuntu.sources
RUN apt-get -y update && apt-get -y install cmake \
                        build-essential \
                        pkg-config \
                        libpython3-dev \
                        python3-numpy \
                        libicu-dev \
                        ninja-build \
                        libboost-all-dev \
                        libeigen3-dev \
                        libmetis-dev \
                        libtbb-dev \
                        libgeographiclib-dev

WORKDIR /gtsam

