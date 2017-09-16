#!/usr/bin/env bash

apt-get update

# TODO: coin-or prints warning: failed to find fortran compiler
# or-tools prerequisites
apt-get install --assume-yes git bison flex python-setuptools python-dev autoconf \
libtool zlib1g-dev texinfo help2man gawk g++ curl texlive cmake subversion

# packaging prerequisites
apt-get install --assume-yes python3 unzip libcurl4-openssl-dev

# GNU linear programming kit development files

mkdir -p ~/dev
pushd ~/dev

if [ ! -d glpk-4.35 ]; then
    wget http://ftp.gnu.org/gnu/glpk/glpk-4.35.tar.gz --quiet -Oglpk-4.35.tar.gz \
    && tar -xzf glpk-4.35.tar.gz \
    && rm glpk-4.35.tar.gz \
    && cd glpk-4.35 \
    && ./configure --with-pic && make && sudo make install
    cd --
fi

if [ ! -d gurobi751 ]; then
    wget http://packages.gurobi.com/7.5/gurobi7.5.1_linux64.tar.gz --quiet -Ogurobi7.5.1.tar.gz \
    && tar -xzf gurobi7.5.1.tar.gz \
    && rm gurobi7.5.1.tar.gz \
    && sudo /bin/cp -rf gurobi751 /opt \
    && cd /opt/gurobi751/linux64/lib \
    && sudo ln -s libgurobi75.so libgurobi.so
    cd --
fi 

if [ ! -d cmake-3.8.2 ]; then
    wget https://cmake.org/files/v3.8/cmake-3.8.2.tar.gz --quiet -Ocmake-3.8.2.tar.gz \
    && tar -xzf cmake-3.8.2.tar.gz \
    && rm cmake-3.8.2.tar.gz \
    && cd cmake-3.8.2 \
    && ./bootstrap --no-qt-gui --system-curl && make && sudo make install
    cd --
fi

sudo ldconfig --verbose

popd
