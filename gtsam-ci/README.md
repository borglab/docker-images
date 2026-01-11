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
- `ubuntu-22.04-gcc-11`: GCC 11

**Ubuntu 24.04:**
- `ubuntu-24.04-clang-16`: Clang 16
- `ubuntu-24.04-gcc-14`: GCC 14

## Build and Push Script

The `build_and_push.sh` script automates the process of building these images and pushing them to Docker Hub.

### Authentication

Before running the script, you must be authenticated with Docker Hub. You can do this by running:

```bash
docker login
```

You will be prompted for your username and password (or access token).

### Usage

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

## Adding a New Image Variant

To support a new Ubuntu version or compiler configuration:

1.  **Create a new Dockerfile**:
    -   Follow the naming convention: `ubuntu-<version>-<compiler>-<version>.Dockerfile` (e.g., `ubuntu-24.04-clang-17.Dockerfile`).
    -   If it's a new base Ubuntu version, create `ubuntu-<version>-base.Dockerfile` first.

2.  **Define the Image**:
    -   Copy an existing Dockerfile that is closest to your target configuration.
    -   Update the `FROM` instruction if necessary.
    -   Update the `RUN` commands to install the desired compiler versions.
    -   For compiler images, ensure you set the environment variables `CC` and `CXX` correctly.

3.  **Build and Test**:
    -   Build the image locally to ensure it works: `docker build -f <your-dockerfile> .`
    -   The `build_and_push.sh` script will automatically pick up the new file because it iterates over `*.Dockerfile`.
