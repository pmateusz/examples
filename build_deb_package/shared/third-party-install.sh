#!/usr/bin/env bash

apt-get update

# or-tools prerequisites
apt-get install --assume-yes git bison flex python-setuptools python-dev autoconf \
libtool zlib1g-dev texinfo help2man gawk g++ curl texlive cmake subversion

# packaging prerequisites
apt-get install --assume-yes python3 unzip gfortran libgflags-dev libcurl4-openssl-dev

. "/shared/glpk/glpk-install.sh"
. "/shared/gurobi/gurobi-install.sh"
# ./cmake/cmake-install.sh

sudo ldconfig
