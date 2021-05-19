#! /bin/bash

set -e

apt update
apt upgrade -y

# open all ubuntu repository
apt install software-properties-common -y
apt install add-apt-repository -y
add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
apt update

# install system dependences
export DEBIAN_FRONTEND=noninteractive
apt install -y mesa-opencl-icd ocl-icd-opencl-dev ntpdate ubuntu-drivers-common gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget
apt upgrade -y

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install golang
wget -c https://golang.org/dl/go1.15.5.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
echo export PATH=/usr/local/go/bin:$PATH >>~/.bashrc

# install lotus
cd ~
git clone https://github.com/filecoin-project/lotus.git
cd ~/lotus
git checkout tags/v1.5.1 -b v1.5.1

# ipfs and go gateway proxy in CHINA
echo export IPFS_GATEWAY=https://proof-parameters.s3.cn-south-1.jdcloud-oss.com/ipfs/ >>~/.bashrc
echo export GOPROXY=https://goproxy.cn >>~/.bashrc

# If you have an AMD Zen or Intel Ice Lake CPU (or later), enable the use of SHA extensions by adding these two environment variables:
echo "export RUSTFLAGS='-C target-cpu=native -g'" >>~/.bashrc
echo export FFI_BUILD_FROM_SOURCE=1 >>~/.bashrc

# Some older Intel and AMD processors without the ADX instruction support may panic with illegal instruction errors. To fix this, add the CGO_CFLAGS environment variable
echo export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__" >>~/.bashrc
echo export CGO_CFLAGS="-D__BLST_PORTABLE__" >>~/.bashrc

source ~/.bashrc

## make
## Calibration with min 32GiB sectors
make clean calibnet
## Nerpa with min 512MiB sectors
#make clean nerpanet
## Main net, production net
# make clean && make all

# Lotus provides generic Systemd service files. They can be installed with
make install-daemon-service
make install-miner-service
