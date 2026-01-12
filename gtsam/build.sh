# Build command for Docker image
# TODO(dellaert): use docker compose and/or cmake
docker build --no-cache -t borglab/gtsam:latest -f Dockerfile .
docker build --no-cache -t borglab/gtsam:latest-tbb -f tbb.Dockerfile .
