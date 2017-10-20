#!/usr/bin/env bash

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

popd