# GTSAM CI Image Release Checklist

Use this checklist when preparing a maintainer-facing handoff for a new `borglab/gtsam-ci` image.

## Source Changes

- Confirm the Dockerfile path follows `gtsam-ci/ubuntu-<version>-<compiler>-<compiler-version>.Dockerfile`.
- Confirm the image tag is `borglab/gtsam-ci:ubuntu-<version>-<compiler>-<compiler-version>`.
- If a new Ubuntu base was needed, confirm `gtsam-ci/ubuntu-<version>-base.Dockerfile` exists and installs the common GTSAM CI dependencies.
- Confirm `gtsam-ci/README.md` lists the new base image and compiler-specific image.
- Confirm `FROM`, package names, `CC`, and `CXX` agree with the intended compiler version.

## Local Build

From the `docker-images` repository root:

```bash
docker build -t borglab/gtsam-ci:<tag> -f gtsam-ci/<tag>.Dockerfile gtsam-ci
```

For a compiler-only smoke test from the repository root:

```bash
.agents/skills/gtsam-ci-image/scripts/smoke_test_image.sh <tag>
```

For a GTSAM checkout smoke test:

```bash
.agents/skills/gtsam-ci-image/scripts/smoke_test_image.sh <tag> /path/to/gtsam
```

## Publish

Publishing is externally visible. Ask the maintainer before running or instructing an agent to run `docker push`.

For a single new tag:

```bash
docker login
docker push borglab/gtsam-ci:<tag>
```

Use `./build_and_push.sh borglab` only when the maintainer intentionally wants to rebuild and push all `gtsam-ci` images.

## GTSAM Repository Follow-Up

After Docker Hub has the new image:

- Update `.github/workflows/build-linux.yml` in `borglab/gtsam`.
- Add or replace the matrix entry that should consume the image.
- Update comments that describe the bracketed compiler range.
- Keep Python CI separate unless the request specifically asks to test Python with the new compiler.
- Link the docker-images PR or commit in the GTSAM PR description so reviewers can confirm the tag provenance.
