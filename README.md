# Docker Images for Borglab

This repository hosts various Dockerfiles used for developing, testing, and distributing software from [Borglab](https://borglab.org/), primarily focusing on [GTSAM](https://github.com/borglab/gtsam) and [GTDynamics](https://github.com/borglab/gtdynamics).

## Directory Structure & Images

Each subdirectory contains a README with specific details.

- **[ubuntu-base](./ubuntu)**:
  Base image (Ubuntu 24.04) with Boost (and optionally, TBB) libraries pre-installed. Serves as a foundation for other images.

- **[gtsam](./gtsam)**:
  A pre-compiled environment containing the latest `develop` branch of GTSAM. Useful for quick testing or as a base for downstream apps.

- **[gtsam-manylinux](./gtsam-manylinux)**:
  An environment based on `manylinux2014` tailored for building Python wheels for GTSAM.

- **[gtdynamics-manylinux](./gtdynamics-manylinux)**:
  Extends `gtsam-manylinux` with Ignition/Gazebo dependencies (SDFormat, ign-math, etc.) for building GTDynamics Python wheels.

- **[gtsam-ci](./gtsam-ci)**:
  A collection of images used in GitHub Actions for Continuous Integration. Includes matrices for different Ubuntu versions (22.04, 24.04) and compilers (Clang, GCC).

## Usage

You can build any of these images locally by navigating to the directory and running `docker build`. Check the specific READMEs for detailed instructions.

Many of these images are available on Docker Hub under the `borglab` namespaces.

## Codex Skills

This repository includes repo-local Codex skills under [`.agents/skills`](./.agents/skills). These skills give maintainers and AI agents project-specific workflows for common maintenance tasks.

Current skills:

- [`gtsam-ci-image`](./.agents/skills/gtsam-ci-image/SKILL.md): create or update GTSAM CI Docker images, smoke test them, and prepare the maintainer handoff for publishing the corresponding `borglab/gtsam-ci` Docker Hub tag.

Example prompt to try from this repository:

```text
Use $gtsam-ci-image to add a new GTSAM CI Docker image for Ubuntu 26.04 with GCC 15. Create the needed Dockerfile(s), update the gtsam-ci README, build the image locally if Docker is available, smoke test it, and give me the maintainer handoff commands for publishing the new borglab/gtsam-ci tag. Do not push anything without asking me first.
```

## Contributing

1. Create a new branch for your changes.
2. If adding a new image, create a new directory with a `Dockerfile` and a `README.md`.
3. Test the build locally.
4. Submit a Pull Request.
