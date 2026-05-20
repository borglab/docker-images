#!/bin/bash

# This script builds and pushes all the docker images in this directory to DockerHub if needed.
# These images are automatically build by DockerHub when changes are pushed to the repository.
# Usage: ./build_and_push.sh <dockerhub-username>

set -e
set -o pipefail
set -x

DOCKERHUB_USERNAME=$1
DOCKER_REPOSITORY="gtsam-ci"
DOCKER_PLATFORM="${DOCKER_PLATFORM:-linux/amd64}"

if [ -z "$DOCKERHUB_USERNAME" ]; then
  echo "Usage: $0 <dockerhub-username>"
  exit 1
fi

# First build and push the base images
for base_dockerfile in *-base.Dockerfile; do
  tag=$(basename "$base_dockerfile" .Dockerfile)
  docker build --platform "$DOCKER_PLATFORM" -t "$DOCKERHUB_USERNAME/$DOCKER_REPOSITORY:$tag" -f "$base_dockerfile" .
  docker push "$DOCKERHUB_USERNAME/$DOCKER_REPOSITORY:$tag"
done

for dockerfile in *.Dockerfile; do
  # Build only non-base images
  if [[ "$dockerfile" == *-base.Dockerfile ]]; then
    continue
  fi

  tag=$(basename "$dockerfile" .Dockerfile)
  docker build --platform "$DOCKER_PLATFORM" -t "$DOCKERHUB_USERNAME/$DOCKER_REPOSITORY:$tag" -f "$dockerfile" .
  docker push "$DOCKERHUB_USERNAME/$DOCKER_REPOSITORY:$tag"
done
