FROM borglab/gtsam-ci:ubuntu-26.04-base

RUN apt-get -y install g++-15 g++-15-multilib binutils-gold

ENV CC="gcc-15"
ENV CXX="g++-15"
ENV LDFLAGS="-fuse-ld=gold"
ENV CMAKE_EXE_LINKER_FLAGS="-fuse-ld=gold"
ENV CMAKE_SHARED_LINKER_FLAGS="-fuse-ld=gold"

# Build GTSAM and run tests
ENTRYPOINT ["bash", ".github/scripts/unix.sh", "-t"]
