#!/bin/bash

# Clean up.
rm -fr ispell-*

echo -n "Downloading ispell ..."
wget -q https://www.cs.hmc.edu/~geoff/tars/ispell-3.4.05.tar.gz
echo ""

echo -n "Unpacking ispell ..."
tar xzf ispell-3.4.05.tar.gz
echo ""

pushd ispell-3.4.05 > /dev/null 2>&1 || exit

echo -n "Configuring ispell ..."
cp local.h.linux local.h
patch -p0 < ../patches/local.patch
patch -p0 < ../patches/ispellh.patch
patch -p0 < ../patches/term.patch
patch -p0 < ../patches/lookup.patch
echo ""

echo -n "Building ispell ..."
make

# To install dictionaries locally, uncomment the following line.
# make install

popd > /dev/null 2>&1 || exit

ln -fn ispell-3.4.05/ispell ispell
