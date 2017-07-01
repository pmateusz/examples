#!/usr/bin/env bash

pushd .

cd /vagrant \
&& rm -Rf build \
&& mkdir -p build && cd build \
&& cmake .. \
&& make dist

popd