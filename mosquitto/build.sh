#!/bin/bash

WITH_SRV=no
WITH_JSON=yes

PY_URL="https://www.python.org/ftp/python/3.10.5/Python-3.10.5.tgz"
PY_ARCHIVE=$(basename "$PY_URL")
PY_FOLDER=$(basename "$PY_ARCHIVE" .tgz)

ROOTFS_ARCHIVE=rootfs.tar

echo "Extracting ${ROOTFS_ARCHIVE} ... "
tar -xf $ROOTFS_ARCHIVE

echo "Removing ${PY_ARCHIVE} and ${PY_FOLDER}/ ... "
rm -rf "$PY_ARCHIVE" "$PY_FOLDER"

echo "Downloading python ... "
if ! wget "$PY_URL";
then
    exit
fi

echo "Unpacking pyton ... "
tar xzf "$PY_ARCHIVE"

echo "Changing directory to ${PY_FOLDER}"
pushd "$PY_FOLDER" || exit

echo "Configuring python ... "
LINKFORSHARED=" " ./configure --prefix="$PWD"/.. CFLAGS="-fPIC -Wall" LDFLAGS="-static-pie"
make
mv python ..
