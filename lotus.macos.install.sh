#! /bin/bash

set -e

# Lotus requires that X-Code CLI tools be installed before building the Lotus binaries
xcodePath=$(xcode-select -p)
if [ -z "${xcodePath}" ]; then
  xcode-select --install
fi

# install homebrew
brewPath=$(which brew)
if [ -z "${brewPath}" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install system dependences
dependences=('go' 'bzr' 'jq' 'pkg-config' 'hwloc')
for i in ${!dependences[@]}; do
  depPath=$(which ${dependences[i]})
  if [ -z "${depPath}" ]; then
    brew install ${dependences[i]}
  fi
done

# install rustup
rustPath=$(which rustup)
if [ -z "${rustPath}" ]; then
  brew install rustup-init
  rustup-init
fi

# clone git repository
mkdir -p $GOPATH/src/github.com/filecoin-project
git clone https://github.com/filecoin-project/lotus.git $GOPATH/src/github.com/filecoin-project/
cd $GOPATH/src/github.com/filecoin-project/lotus/
git checkout tags/v1.5.1 -b v1.5.1

# Some older Intel and AMD processors without the ADX instruction support may panic with illegal instruction errors. To fix this, add the CGO_CFLAGS environment variable
export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
export CGO_CFLAGS="-D__BLST_PORTABLE__"

# ipfs and go gateway proxy in CHINA
export IPFS_GATEWAY=https://proof-parameters.s3.cn-south-1.jdcloud-oss.com/ipfs/
export GOPROXY=https://goproxy.cn

# build lotus
make clean && make all # mainnet

# Or to join a testnet or devnet:
# Calibration with min 32 GiB sectors
# make clean && make calibnet
# Nerpa with min 512 MiB sectors
# make clean && make nerpanet

make install
