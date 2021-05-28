FROM ubuntu:20.04

RUN apt update
RUN apt upgrade -y

ARG DEBIAN_FRONTEND=noninteractive
RUN apt install -y --no-install-recommends build-essential \
  mesa-opencl-icd \
  ocl-icd-opencl-dev \
  gcc \
  git \
  jq \
  pkg-config \
  curl \
  clang \
  build-essential \
  hwloc \
  libhwloc-dev \
  wget \
  bzr

RUN apt upgrade -y

ENV RUSTUP_HOME=/rust
ENV CARGO_HOME=/cargo
ENV PATH=/cargo/bin:/rust/bin:$PATH
RUN (curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly --no-modify-path) && rustup default nightly
# RUN echo "(curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly --no-modify-path) && rustup default nightly" > /install-rust.sh && chmod 755 /install-rust.sh

RUN wget -c https://golang.google.cn/dl/go1.16.2.linux-amd64.tar.gz -O - | tar -xz -C /usr/local
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/root/go
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc
RUN echo "export GOPATH=/root/go" >> ~/.bashrc