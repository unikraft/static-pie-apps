#!/bin/bash

BZIP2_URL="https://www.sourceware.org/pub/bzip2/bzip2-latest.tar.gz"

rm -rf bzip2-*

echo -n "Downloading bzip2 ... "
wget -q "$BZIP2_URL"

echo ""
echo -n "Unpacking bzip2 ... "
tar xzf bzip2-latest.tar.gz

pushd bzip2-1.0.8 > /dev/null 2>&1 || exit 1
echo -n "Patching bzip2 build files... "
patch -p1 < ../../patches/0001-Add-static-PIE-flag.patch

echo -n "Building bzip2 ... "
make 

popd > /dev/null 2>&1 || exit 1

ln -fn bzip2-1.0.8/bzip2 .

rm -rf bzip2-*
