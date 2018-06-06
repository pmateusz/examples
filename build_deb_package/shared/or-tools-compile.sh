#!/usr/bin/env bash

pushd .

mkdir -p ~/dev
pushd dev

if [ ! -d or-tools ]; then
    wget https://github.com/google/or-tools/archive/v6.7.1.zip --quiet -Omaster.zip \
    && unzip master.zip -d . \
    && rm master.zip \
    && mv or-tools-6.7.1 or-tools
fi

pushd or-tools \
&& export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/gurobi751/linux64/lib \
&& make third_party \
&& make cc UNIX_GLPK_DIR=/usr/local UNIX_GUROBI_DIR=/opt/gurobi751 GUROBI_LIB_VERSION=75 GUROBI_PLATFORM=linux64

popd
popd
popd
