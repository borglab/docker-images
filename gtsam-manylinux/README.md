# GTSAM Manylinux Image

This image is the base environment for building `manylinux` compliant Python wheels for GTSAM.

## Image Details

- **Base Image:** `quay.io/pypa/manylinux2014_x86_64` (CentOS 7 based)
- **Installed Dependencies:**
  - `devtoolset-7-gcc-c++` (Modern GCC)
  - `libicu-devel`
  - `Boost` 1.89.0 (Compiled from source, static libraries)

## Purpose

The primary use of this image is in CI pipelines to generate binary wheels for GTSAM that are compatible with a wide range of Linux distributions.

## Build Instructions

```bash
cd gtsam-manylinux
docker build -t gtsam-manylinux .
```
