#!/bin/bash


BUILD_VERSION=20221126
# Clean up.
rm -fr *.tar.gz

echo -n "Downloading iputils ... "
wget -O "${BUILD_VERSION}.tar.gz" -q https://github.com/iputils/iputils/archive/refs/tags/${BUILD_VERSION}.tar.gz
echo ""

echo -n "Unpacking iputils ... "
tar xzf "${BUILD_VERSION}.tar.gz"
echo ""

SOURCE_DIR="iputils-${BUILD_VERSION}"
pushd "${SOURCE_DIR}" > /dev/null 2>&1

# echo "Patching iputils files ... "
# patch -p1 < ../config.patch
# echo ""

echo "Building ... "
./configure --prefix=.
make

popd > /dev/null 2>&1

ln -fn "${SOURCE_DIR}/builddir/ping/ping" .
ln -fn "${SOURCE_DIR}/builddir/arping" .
ln -fn "${SOURCE_DIR}/builddir/tracepath" .
ln -fn "${SOURCE_DIR}/builddir/clockdiff" .
