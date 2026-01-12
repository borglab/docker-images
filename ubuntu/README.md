# Ubuntu Image with optional Boost & TBB

This directory contains the Dockerfiles for a base Ubuntu image pre-installed with Boost, as well as a version with TBB (Threading Building Blocks) libraries.
It is designed to serve as a foundational image for other C++ projects, specifically those in the GTSAM ecosystem.

## Image Details

- **Base Image:** `ubuntu:noble` (Ubuntu 24.04 LTS)
- **Pre-installed Libraries:**
  - `build-essential` (GCC/G++ compilers, Make, etc.)
  - `cmake`
  - `libboost-all-dev` (Boost C++ Libraries)
  - `libtbb-dev` (Intel Threading Building Blocks)
  - `apt-utils`

## Usage

These images are intended to be used in a `FROM` instruction in downstream Dockerfiles:

```dockerfile
FROM borglab/ubuntu-base:latest
# or FROM borglab/ubuntu-base:latest-tbb

# Your project specific instructions
COPY . /app
WORKDIR /app
RUN cmake . && make
```

## Build Instructions

To build this image locally:

```bash
cd ubuntu
docker build -t borglab/ubuntu-base:latest -f ubuntu.Dockerfile .
docker build -t borglab/ubuntu-base:latest-tbb -f ubuntu-tbb.Dockerfile .
```
