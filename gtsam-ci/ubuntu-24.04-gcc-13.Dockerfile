FROM borglab/gtsam-ci:ubuntu-24.04-base

RUN apt-get -y update && apt-get -y install g++-13 g++-13-multilib binutils-gold

ENV CC="gcc-13"
ENV CXX="g++-13"
ENV LDFLAGS="-fuse-ld=gold"
ENV CMAKE_EXE_LINKER_FLAGS="-fuse-ld=gold"
ENV CMAKE_SHARED_LINKER_FLAGS="-fuse-ld=gold"

# Build GTSAM and run tests
ENTRYPOINT ["bash", ".github/scripts/unix.sh", "-t"]
