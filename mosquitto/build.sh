#!/bin/bash

WITH_SRV=no
WITH_JSON=yes

WITH_WEBSOCKETS=no
WITH_TLS=yes
WITH_BUNDLED_DEPS=yes
WITH_DOCS=no


URL="https://mosquitto.org/files/source/mosquitto-2.0.14.tar.gz"
ARCHIVE=$(basename "$URL")
FOLDER=$(basename "$ARCHIVE" .tar.gz)
SRC="$FOLDER"/src

echo $URL $ARCHIVE $FOLDER

ROOTFS_ARCHIVE=rootfs.tar

echo "Extracting ${ROOTFS_ARCHIVE} ... "
tar -xgzf $ROOTFS_ARCHIVE

echo "Removing ${ARCHIVE} and ${FOLDER}/ ... "
rm -rf "$ARCHIVE" "$FOLDER"

echo "Downloading mosquitto ... "
if ! wget "$URL";
then
    exit
fi

echo "Unpacking mosquitto ... "
tar xzf "$ARCHIVE"

echo "Changing directory to ${FOLDER}"
pushd $SRC || exit

echo "Building mosquitto ... "
make    CFLAGS="-fPIC" BROKER_LDFLAGS="-static-pie" LDADD="-ldl -lpthread" \
        WITH_SRV=$WITH_SRV \
        WITH_JSON=$WITH_JSON \
        WITH_WEBSOCKETS=$WITH_WEBSOCKETS \
        WITH_TLS=$WITH_TLS \
        WITH_BUNDLED_DEPS=$WITH_BUNDLED_DEPS \
        WITH_DOCS=$WITH_DOCS

popd
mv "$SRC"/mosquitto .
