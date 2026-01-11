# GTDynamics Manylinux Image

This image is specialized for building Python wheels for [GTDynamics](https://github.com/borglab/gtdynamics). It extends the `gtsam-manylinux` image by adding necessary dependencies from the Ignition (now Gazebo) ecosystem.

## Image Details

- **Base Image:** `varunagrawal/gtsam-manylinux:latest`
- **Added Dependencies:**
  - `sdformat8` (from source, version 8.6.1)
  - `ign-cmake2` (from source)
  - `ign-math6` (from source)
  - `ign-tools0` (from source)
  - `ruby-devel`, `tinyxml-devel`, `eigen3-devel`

## Purpose

This image provides the environment required to compile GTDynamics and produce `manylinux` compliant Python wheels that can be distributed via PyPI.

## Build Instructions

```bash
cd gtdynamics-manylinux
docker build -t gtdynamics-manylinux .
```
