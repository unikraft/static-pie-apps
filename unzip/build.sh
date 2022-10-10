#!/bin/bash

APP=unzip
DIR=${APP}60
ARCHIVE=${DIR}.tar.gz
URL=https://downloads.sourceforge.net/infozip/${ARCHIVE}

# Clean up
rm -rf ${ARCHIVE}
rm -rf ${DIR}

echo -n "Downloading ${APP} sources ... "
wget -q ${URL}
if test $? -ne 0; then
    echo ""
    echo "Unable to download ${APP} from ${URL}"
    exit 1
fi
echo "DONE"

echo ""
echo -n "Unpacking ${APP} ... "
tar -zxvf ${ARCHIVE}
if test $? -ne 0; then
    echo ""
    echo "Unable to extract ${APP}"
    exit 1
fi
echo "DONE"

echo ""
echo -n "Building ${APP} ... "
echo ""
pushd ${DIR} > /dev/null 2>&1 || exit 1

patch -p1 < ../patches/add-static-pie-flag.patch
make -f unix/Makefile generic

popd > /dev/null 2>&1 || exit 1

cp ${DIR}/${APP} .

rm -rf ${DIR}
rm -rf ${ARCHIVE}

echo -n "Build complete!"
