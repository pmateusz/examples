#!/usr/bin/env bash

pushd .

mkdir -p ~/dev && cd ~/dev \
&& wget https://github.com/google/or-tools/archive/master.zip --quiet -Omaster.zip \
&& unzip master.zip -d . \
&& rm master.zip \
&& mv or-tools-master or-tools && cd or-tools

make third_party \
&& make cc

popd
