#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  smoke_test_image.sh <tag-or-image> [gtsam-repo]

Examples:
  smoke_test_image.sh ubuntu-26.04-gcc-15
  smoke_test_image.sh borglab/gtsam-ci:ubuntu-26.04-gcc-15 /path/to/gtsam
USAGE
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
  usage >&2
  exit 2
fi

image="$1"
gtsam_repo="${2:-}"

if [[ "$image" != *:* ]]; then
  image="borglab/gtsam-ci:${image}"
elif [[ "$image" != */* ]]; then
  image="borglab/${image}"
fi

docker image inspect "$image" >/dev/null

docker run --rm --entrypoint bash "$image" -lc '
  set -euo pipefail
  echo "CC=${CC:-}"
  echo "CXX=${CXX:-}"
  "${CC:-cc}" --version
  "${CXX:-c++}" --version
  cmake --version
'

if [[ -n "$gtsam_repo" ]]; then
  if [[ ! -d "$gtsam_repo/.git" || ! -f "$gtsam_repo/.github/scripts/unix.sh" ]]; then
    echo "Not a GTSAM checkout: $gtsam_repo" >&2
    exit 2
  fi

  docker run --rm \
    --volume "$gtsam_repo:/gtsam" \
    --workdir /gtsam \
    "$image"
fi
