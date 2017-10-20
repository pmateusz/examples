#!/usr/bin/env bash

mkdir -p ~/dev
pushd ~/dev

if [ ! -d gurobi751 ]; then
    wget http://packages.gurobi.com/7.5/gurobi7.5.1_linux64.tar.gz --quiet -Ogurobi7.5.1.tar.gz \
    && tar -xzf gurobi7.5.1.tar.gz \
    && rm gurobi7.5.1.tar.gz \
    && sudo /bin/cp -rf gurobi751 /opt \
    && cd /opt/gurobi751/linux64/lib \
    && sudo ln -s libgurobi75.so libgurobi.so
    cd --
fi 

popd