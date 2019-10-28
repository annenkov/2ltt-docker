FROM ubuntu:18.04
MAINTAINER Danil Annenkov <http://dannenkov.me>

# Lean build flags
ENV CMAKE_FLAGS="-D CMAKE_BUILD_TYPE=RELEASE -D BOOST=OFF -D TCMALLOC=OFF -G Ninja"

# Set non-interactive mode
ARG DEBIAN_FRONTEND=noninteractive

ENV LANG C.UTF-8

# Install the required packages
RUN apt-get update
RUN apt-get -y dist-upgrade
# RUN apt-get update && apt-get install -y python-software-properties && apt-get install software-properties-common -y && add-apt-get-repository ppa:ubuntu-toolchain-r/test -y
RUN apt-get update

RUN apt-get install \
  python \
  git \
  libgmp-dev \
  libmpfr-dev \
  emacs -y


RUN apt-get -y install \
  cmake \
  liblua5.2.0 \ 
  lua5.2-0 \ 
  lua5.2-dev -y

RUN apt-get -y install \
    gitg \
    ninja-build \
    valgrind \
    doxygen

# RUN update-alternatives --remove-all gcc

# RUN update-alternatives --remove-all g++

# RUN apt-get update
RUN apt-get install g++-4.8 -y
RUN apt-get upgrade -y && apt-get dist-upgrade -y

RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 0

RUN g++ --version

# Download from the repository, build, clean up
RUN \
  git clone --depth 1 https://github.com/leanprover/lean2.git && \
  mkdir -p lean2/build && \
  (cd lean2/build; cmake $CMAKE_FLAGS ../src && ninja && ninja install) && \
  lean --version && \
  rm -rf lean

RUN cd ~ && git clone https://github.com/annenkov/two-level.git && cd two-level && make

RUN mkdir /root/.emacs.d
ADD init.el /root/.emacs.d
RUN ls ~/.emacs.d
RUN emacs --batch -l /root/.emacs.d/init.el

# This is just a convenience for running the container. It can be overridden.
ENTRYPOINT ["/bin/bash"]
