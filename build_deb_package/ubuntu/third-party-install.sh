#!/usr/bin/env bash

apt-get update

# or-tools prerequisites
apt-get install --assume-yes git bison flex python-setuptools python-dev autoconf \
libtool zlib1g-dev texinfo help2man gawk g++ curl texlive cmake subversion

# packaging prerequisites
apt-get install --assume-yes python3 unzip libcurl4-openssl-dev

pushd .

# mkdir -p ~/Applications && cd ~/Applications
# wget --quiet https://www.open-mpi.org/software/hwloc/v1.11/downloads/hwloc-1.11.4.tar.gz
# tar -xvzf hwloc-1.11.4.tar.gz
# rm hwloc-1.11.4.tar.gz
# cd hwloc-1.11.4
# ./configure && make install

popd
