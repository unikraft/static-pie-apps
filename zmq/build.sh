#!/bin/bash

LIBNAME=libzmq
MAJOR_VERSION=4
MINOR_VERSION=3.4
ARCHIVE=v${MAJOR_VERSION}.${MINOR_VERSION}.tar.gz
DIRNAME=${LIBNAME}-${MAJOR_VERSION}.${MINOR_VERSION}
URL=https://github.com/zeromq/${LIBNAME}/archive/refs/tags/v${MAJOR_VERSION}.${MINOR_VERSION}.tar.gz

# Clean up
rm -rf ${ARCHIVE}
rm -rf ${DIRNAME}

echo -n "Downloading ZeroMQ ... "
wget -q "${URL}"
if test $? -ne 0; then
	echo ""
	echo "Unable to download ZeroMQ from ${URL}"
	exit 1
fi
echo "DONE"

echo -n "Extracting ZeroMQ ... "
tar xzf ${ARCHIVE}
if test $? -ne 0; then
	echo ""
	echo "Unable to extract ${LIBNAME}"
	exit 1
fi
echo "DONE"

pushd "$DIRNAME" > /dev/null 2>&1 || exit 1

echo "Biulding the ZeroMQ library ..."

# Configure libzmq for static-PIE building
./autogen.sh
./configure --enable-static
make -j "$(nproc)"

popd > /dev/null 2>&1 || exit 1

ln -fn ${DIRNAME}/include/zmq.h .
ln -fn ${DIRNAME}/src/.libs/libzmq.a .

make

rm -rf "${DIRNAME}"
rm -f "${ARCHIVE}"
