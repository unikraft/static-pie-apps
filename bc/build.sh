#!/bin/bash


BC_VERSION=bc-1.03
# Clean up.
rm -fr bc-*

echo -n "Downloading bc ... "
wget -q https://ftp.gnu.org/gnu/bc/${BC_VERSION}.tar.gz
echo ""

echo -n "Unpacking bc ... "
tar xzf ${BC_VERSION}.tar.gz
echo ""

pushd ${BC_VERSION} > /dev/null 2>&1

echo "Patching bc build files ... "
patch -p1 < ../config.patch
echo ""

echo "Building bc ... "
./configure --prefix=.
make
popd > /dev/null 2>&1

ln -fn ${BC_VERSION}/bc .
