---
name: gtsam-ci-image
description: Create or update GTSAM CI Docker images in borglab/docker-images. Use when adding a new Ubuntu/compiler image such as ubuntu-26.04-gcc-15, updating gtsam-ci Dockerfiles, testing image tags used by GTSAM GitHub Actions, or guiding a maintainer through building and publishing GTSAM CI images to Docker Hub.
---

# GTSAM CI Image

## Scope

Work from the `docker-images` repository, especially `gtsam-ci/`. The GTSAM repository consumes these images from GitHub Actions as:

```text
borglab/gtsam-ci:${{ matrix.os }}-${{ matrix.compiler }}-${{ matrix.version }}
```

The image tag and Dockerfile basename must match:

```text
gtsam-ci/ubuntu-<ubuntu-version>-<compiler>-<compiler-version>.Dockerfile
borglab/gtsam-ci:ubuntu-<ubuntu-version>-<compiler>-<compiler-version>
```

Examples: `ubuntu-22.04-gcc-11`, `ubuntu-24.04-gcc-14`, `ubuntu-24.04-clang-16`.

## Workflow

1. Inspect `gtsam-ci/README.md`, existing `gtsam-ci/*.Dockerfile`, and the target GTSAM workflow that will consume the image.
2. Choose the nearest existing Dockerfile as the pattern.
3. If the Ubuntu version is new, add `ubuntu-<version>-base.Dockerfile` first and keep dependencies consistent with the closest maintained base image.
4. Add the compiler-specific Dockerfile:
   - Set `FROM borglab/gtsam-ci:ubuntu-<version>-base`.
   - Install the exact compiler packages, such as `g++-15 g++-15-multilib binutils-gold`.
   - Set `CC`, `CXX`, `LDFLAGS`, `CMAKE_EXE_LINKER_FLAGS`, and `CMAKE_SHARED_LINKER_FLAGS` consistently with existing GCC/Clang images.
   - Keep `ENTRYPOINT ["bash", ".github/scripts/unix.sh", "-t"]`.
5. Update `gtsam-ci/README.md` so the image list documents the new base/compiler variant.
6. Build and smoke test locally before proposing workflow changes in `borglab/gtsam`.
7. Guide, but do not perform, any Docker Hub push unless the maintainer explicitly asks for that external action.
8. After the image is published, update the consuming GTSAM workflow matrix and comments in the GTSAM repository.

## Commands

Build one image from the `docker-images` repository root:

```bash
docker build -t borglab/gtsam-ci:<tag> -f gtsam-ci/<tag>.Dockerfile gtsam-ci
```

Smoke test one built image from the repository root:

```bash
.agents/skills/gtsam-ci-image/scripts/smoke_test_image.sh <tag>
```

Smoke test against a local GTSAM checkout:

```bash
.agents/skills/gtsam-ci-image/scripts/smoke_test_image.sh <tag> /path/to/gtsam
```

If the maintainer wants to publish only the new tag, ask for confirmation first, then guide them through:

```bash
docker login
docker push borglab/gtsam-ci:<tag>
```

After the maintainer confirms the image has been pushed or built by Docker Hub, include optional local cleanup commands for any tags built during validation:

```bash
docker image rm borglab/gtsam-ci:<tag>
docker buildx prune -f
```

If a new base image was also built, include its tag in the same `docker image rm` command. Note that `docker buildx prune -f` removes unused BuildKit cache beyond this one image family and can make future local Docker rebuilds slower.

`gtsam-ci/build_and_push.sh borglab` builds and pushes every image in `gtsam-ci/`; mention that broader blast radius before recommending it.

## Validation

Use `references/release-checklist.md` when preparing the maintainer-facing upload instructions. Use `scripts/smoke_test_image.sh` for local validation when Docker is available.

When Docker is unavailable or the image cannot be built locally, say that explicitly and provide the exact commands the maintainer should run.

Never assume a tag exists on Docker Hub just because a Dockerfile exists locally. Verify by pulling it or treat publication as a required maintainer step.
