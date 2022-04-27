#!/bin/bash

# Clean up.
rm -fr redis-*

echo -n "Downloading redis ... "
wget -q https://download.redis.io/releases/redis-6.2.6.tar.gz
echo ""

echo -n "Unpacking redis ... "
tar xzf redis-6.2.6.tar.gz
echo ""

pushd redis-6.2.6 > /dev/null 2>&1

echo -n "Patching redis build files ... "
patch -p0 < ../makefile.patch
echo ""

echo -n "Building redis ... "
make
popd > /dev/null 2>&1

ln -fn redis-6.2.6/src/redis-server .
