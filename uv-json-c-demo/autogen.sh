#! /bin/env bash

function xecho () { >&2 echo "STATUS:" "$@"; }

NJOBS="$(nproc)"

xecho "Cleanup"
rm -fr hello-unikernel

xecho "Cloning the repo"
git clone https://github.com/andreiosg/hello-unikernel.git

xecho "Change working directory to repo root"
pushd hello-unikernel || exit

xecho "Applying static-pie patch"
patch -p1 < ../patch.diff

xecho "Cloning dependencies"
git clone https://github.com/libuv/libuv.git
git clone https://github.com/json-c/json-c.git

xecho "Building LibUV"
mkdir libuv/build
pushd "$_" || exit
cmake ..
make -j"$NJOBS"
popd || exit

xecho "Building JSON-C"
mkdir "json-c/build"
pushd "$_" || exit
cmake ..
make -j"$NJOBS"
popd || exit

xecho "Build the static-pie libuv json-c demo binary"
mkdir "build" && pushd "$_" || exit
cmake ..
make -j"$NJOBS"

xecho "Move to starting workdir"
popd +1 || exit
