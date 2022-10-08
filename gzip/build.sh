#!/bin/bash

APPNAME=gzip
VERSION=1.12
DIRNAME=${APPNAME}-${VERSION}
ARCHIVE=${DIRNAME}.zip
URL=https://ftp.gnu.org/gnu/${APPNAME}/${APPNAME}-${VERSION}.zip

# Clean up
rm -rf ${ARCHIVE}
rm -rf ${DIRNAME}

echo -n "Downloading ${APPNAME} sources ... "
wget -q ${URL}
if test $? -ne 0; then
    echo ""
    echo "Unable to download ${APPNAME} from ${URL}"
    exit 1
fi
echo "DONE"

echo ""
echo -n "Unpacking gzip ... "
unzip -q -o ${ARCHIVE}
if test $? -ne 0; then
    echo ""
    echo "Unable to extract ${APPNAME}"
    exit 1
fi
echo "DONE"

echo ""
echo -n "Building ${APPNAME} ... "
pushd ${DIRNAME} > /dev/null 2>&1 || exit 1

./configure
patch Makefile < ../patches/Makefile.patch
make

popd > /dev/null 2>&1 || exit 1

cp ${DIRNAME}/gzip .

rm -rf ${DIRNAME}
rm -rf ${ARCHIVE}

echo -n "Build complete!"
