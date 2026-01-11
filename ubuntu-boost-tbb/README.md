# Ubuntu Boost & TBB Image

This directory contains the Dockerfile for a base Ubuntu image pre-installed with Boost and TBB (Threading Building Blocks) libraries. It is designed to serve as a foundational image for other C++ projects, specifically those in the GTSAM ecosystem.

## Image Details

- **Base Image:** `ubuntu:noble` (Ubuntu 24.04 LTS)
- **Pre-installed Libraries:**
  - `build-essential` (GCC/G++ compilers, Make, etc.)
  - `cmake`
  - `libboost-all-dev` (Boost C++ Libraries)
  - `libtbb-dev` (Intel Threading Building Blocks)
  - `apt-utils`

## Usage

This image is intended to be used in a `FROM` instruction in downstream Dockerfiles:

```dockerfile
FROM borglab/ubuntu-boost-tbb:latest

# Your project specific instructions
COPY . /app
WORKDIR /app
RUN cmake . && make
```

## Build Instructions

To build this image locally:

```bash
cd ubuntu-boost-tbb
docker build -t ubuntu-boost-tbb .
```
