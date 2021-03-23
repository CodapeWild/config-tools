#! /bin/bash

set -e

apt update
apt upgrade -y

# install system dependences
apt install mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget -y
apt upgrade -y

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install golang
wget -c https://golang.org/dl/go1.15.5.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
export PAHT=/usr/local/go/bin:$PATH

# install lotus
git clone https://github.com/filecoin-project/lotus.git
cd lotus/
git checkout tags/v1.5.1 -b v1.5.1

# ipfs and go gateway proxy in CHINA
export IPFS_GATEWAY=https://proof-parameters.s3.cn-south-1.jdcloud-oss.com/ipfs/
export GOPROXY=https://goproxy.cn

# If you have an AMD Zen or Intel Ice Lake CPU (or later), enable the use of SHA extensions by adding these two environment variables:
export RUSTFLAGS="-C target-cpu=native -g"
export FFI_BUILD_FROM_SOURCE=1

# Some older Intel and AMD processors without the ADX instruction support may panic with illegal instruction errors. To fix this, add the CGO_CFLAGS environment variable
export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
export CGO_CFLAGS="-D__BLST_PORTABLE__"

# make and install
#make clean calibnet # Calibration with min 32GiB sectors
#make clean nerpanet # Nerpa with min 512MiB sectors
make clean && make all

# Lotus provides generic Systemd service files. They can be installed with
make install-daemon-service
make install-miner-service
