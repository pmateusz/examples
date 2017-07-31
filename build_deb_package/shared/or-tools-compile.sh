#!/usr/bin/env bash

pushd .

mkdir -p ~/dev \
&& pushd dev

if [ ! -d or-tools ]; then
    wget https://github.com/google/or-tools/archive/v6.2.zip --quiet -Omaster.zip \
    && unzip master.zip -d . \
    && rm master.zip \
    && mv or-tools-6.2 or-tools
fi

pushd or-tools \
&& make third_party \
&& make cc

popd
popd
popd
