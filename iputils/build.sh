#!/bin/bash


BUILD_VERSION=20221126
# Clean up.
rm -fr *.tar.gz

echo -n "Downloading bc ... "
wget -O "${BUILD_VERSION}.tar.gz" -q https://github.com/iputils/iputils/archive/refs/tags/${BUILD_VERSION}.tar.gz
echo ""

echo -n "Unpacking bc ... "
tar xzf "${BUILD_VERSION}.tar.gz"
echo ""

pushd "iputils-${BUILD_VERSION}" > /dev/null 2>&1

# echo "Patching bc build files ... "
# patch -p1 < ../config.patch
# echo ""

echo "Building ... "
./configure --prefix=.
make

popd > /dev/null 2>&1

ln -fn "${BUILD_VERSION}/bc" .
