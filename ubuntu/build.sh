# Build command for Docker image
# TODO(dellaert): use docker compose and/or cmake
docker build --no-cache -t borglab/ubuntu-base:latest -f ubuntu.Dockerfile .
docker build --no-cache -t borglab/ubuntu-base:latest-tbb -f ubuntu-tbb.Dockerfile .
