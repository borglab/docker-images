# Basic Ubuntu 24.04 (noble) image with Boost and TBB installed. To be used for building further downstream packages.

# Get the base Ubuntu image from Docker Hub
FROM borglab/ubuntu-base:latest

# Disable GUI prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update apps on the base image
RUN apt-get -y update && apt-get -y install

# Install C++
RUN apt-get -y install build-essential  apt-utils

# Install boost and cmake
RUN apt-get -y install libboost-all-dev cmake

# Install TBB
RUN apt-get -y install libtbb-dev
