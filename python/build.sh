#!/bin/bash

PY_URL="https://www.python.org/ftp/python/3.10.5/Python-3.10.5.tgz"
PY_ARCHIVE=$(basename "$PY_URL")
PY_FOLDER=$(basename "$PY_ARCHIVE" .tgz)

echo "Removing ${PY_ARCHIVE} and ${PY_FOLDER}/ ... "
rm -rf "$PY_ARCHIVE" "$PY_FOLDER"

echo -n "Downloading Python ... "
wget -q "$PY_URL"
if test $? -ne 0; then
    echo "error"
    exit 1
fi
echo ""

echo -n "Unpacking Python ... "
tar xzf "$PY_ARCHIVE"
echo ""

pushd "$PY_FOLDER" > /dev/null 2>&1 || exit 1

echo "Patching Python build files ... "
patch -p0 < ../patches/Makefile.pre.in.patch
patch -p0 < ../patches/main.patch
cp ../patches/Setup.local Modules/

echo "Configuring Python ... "
./configure LINKFORSHARED=" " CFLAGS="-Wall -g" --disable-shared

echo -n "Bulding Python ..."
make -j "$(nproc)"

pushd "Lib/" > /dev/null 2>&1 || exit 1
tar --transform "s/^/rootfs\\//" -cf ../../rootfs.tar *
popd > /dev/null 2>&1 || exit 1

popd > /dev/null 2>&1 || exit 1

ln -fn "${PY_FOLDER}"/python .
