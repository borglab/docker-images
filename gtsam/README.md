# GTSAM Develop Image

This image provides a pre-compiled environment for [GTSAM](https://github.com/borglab/gtsam) (Georgia Tech Smoothing and Mapping library). It is built off the `develop` branch of GTSAM.

## Image Details

- **Base Images:**
  - `borglab/ubuntu-base:latest` (Ubuntu 24.04)
  - `borglab/ubuntu-base:latest-tbb` (Ubuntu 24.04 + Boost + TBB)
- **GTSAM Version:** `develop` branch (HEAD at time of build)
- **Configuration:**
  - `CMAKE_BUILD_TYPE=Release`
  - `GTSAM_WITH_EIGEN_MKL=OFF`
  - `GTSAM_BUILD_EXAMPLES_ALWAYS=OFF`
  - `GTSAM_BUILD_TESTS=OFF`
  - Installs to `/usr/local`

## Usage

You can use this image to run GTSAM applications or as a base for projects that depend on GTSAM.

```bash
docker run -it borglab/gtsam:latest bash
```

Or in a Dockerfile:

```dockerfile
FROM borglab/gtsam:latest

# Build your project that links against GTSAM
COPY . /my-project
WORKDIR /my-project
# ...
```

To use the version with TBB, 
## Build Instructions

```bash
cd gtsam
docker build -t gtsam .
```
