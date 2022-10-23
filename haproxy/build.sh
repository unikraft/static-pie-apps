\#!/bin/bash

# Clean up.
rm -fr haproxy-git

echo -n "Downloading HAProxy ... "
git clone https://github.com/haproxy/haproxy.git haproxy-git
echo ""
echo -n "Building HAProxy ... "
pushd haproxy-git > /dev/null 2>&1
patch Makefile < ../Makefile.patch
make TARGET=linux-glibc-legacy
popd > /dev/null 2>&1

cp haproxy-git/haproxy .
rm -fr haproxy-git
