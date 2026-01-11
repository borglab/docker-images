# GTSAM CI Images

This directory contains Dockerfiles and scripts for generating Docker images used in the Continuous Integration (CI) pipelines for GTSAM.

## Image Variants

The images are organized by Ubuntu version and Compiler version to ensure GTSAM compiles across different environments.

### Base Images
- `ubuntu-22.04-base`: Ubuntu 22.04 with common dependencies (CMake, Boost, Eigen, TBB, etc.).
- `ubuntu-24.04-base`: Ubuntu 24.04 with common dependencies.

### Compiler-Specific Images
These extend the base images by setting up specific compilers.

**Ubuntu 22.04:**
- `ubuntu-22.04-clang-11`: Clang 11
- `ubuntu-22.04-clang-14`: Clang 14
- `ubuntu-22.04-gcc-9`: GCC 9

**Ubuntu 24.04:**
- `ubuntu-24.04-clang-16`: Clang 16
- `ubuntu-24.04-gcc-14`: GCC 14

## Build and Push Script

The `build_and_push.sh` script automates the process of building these images and pushing them to Docker Hub.

**Usage:**
```bash
./build_and_push.sh <dockerhub-username>
```

This script:
1. Builds all `*-base.Dockerfile` images first.
2. Pushes base images to Docker Hub.
3. Builds the compiler-specific images (which depend on the base images).
4. Pushes specific images to Docker Hub.

## Dependencies

The base images install a comprehensive suite of development tools required by GTSAM, including:
- `build-essential`
- `cmake`, `ninja-build`
- `libboost-all-dev`
- `libeigen3-dev`
- `libtbb-dev`
- `libmetis-dev`
- `python3-numpy`, `libpython3-dev`
