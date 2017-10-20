#!/usr/bin/env bash

mkdir -p ~/dev
pushd ~/dev

if [ ! -d cmake-3.8.2 ]; then
    wget https://cmake.org/files/v3.8/cmake-3.8.2.tar.gz --quiet -Ocmake-3.8.2.tar.gz \
    && tar -xzf cmake-3.8.2.tar.gz \
    && rm cmake-3.8.2.tar.gz \
    && cd cmake-3.8.2 \
    && ./bootstrap --no-qt-gui --system-curl && make && sudo make install
    cd --
fi

popd