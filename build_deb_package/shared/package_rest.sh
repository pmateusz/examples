#!/usr/bin/env bash

download_compile_package()
{
    echo "Building $1"
    rm -Rf "$1" \
    && mkdir -p "$1" \
    && pushd "$1" \
    && cmake "/shared/$1" \
    && make \
    && make dist \
    && /bin/cp -f *.deb /vagrant \
    && popd
}

pushd .

download_compile_package glog
download_compile_package gflags
download_compile_package gtest

popd