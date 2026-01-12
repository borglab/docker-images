FROM borglab/gtsam-manylinux:latest

# Disable GUI prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install sdformat8
RUN yum install -y ruby-devel tinyxml-devel eigen3-devel

RUN git clone https://github.com/ignitionrobotics/ign-cmake.git -b ign-cmake2 /ign-cmake2
WORKDIR /ign-cmake2/build
RUN cmake /ign-cmake2 && make -j2 install

WORKDIR /
RUN git clone https://github.com/ignitionrobotics/ign-math.git -b ign-math6 /ign-math6
WORKDIR /ign-math6/build
RUN cmake /ign-math6 && make -j2 install

WORKDIR /
RUN git clone https://github.com/ignitionrobotics/ign-tools.git -b ign-tools0 /ign-tools0
WORKDIR /ign-tools0/build
RUN cmake /ign-tools0 && make -j2 install

WORKDIR /
RUN wget http://osrf-distributions.s3.amazonaws.com/sdformat/releases/sdformat-8.6.1.tar.bz2
RUN tar -xvjf sdformat-8.6.1.tar.bz2

WORKDIR /sdformat-8.6.1/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/usr && make -j2 install

WORKDIR /
