#!/bin/bash

DEBUG_ARGS=" --debug --debug-node --debug-lib"
ARGS="--fully-static --enable-static --download=all --with-intl=full-icu"

if [ $# -eq 1 ] && [ "$1" == "debug" ];
then
ARGS+=$DEBUG_ARGS
fi

# Clean up.
rm -rf node-*

echo -n "Downloading nodejs ... "
wget -q https://nodejs.org/dist/v18.14.0/node-v18.14.0.tar.gz
echo ""

echo -n "Unpacking nodejs ... "
tar xzf node-v18.14.0.tar.gz
echo ""

pushd node-v18.14.0 > /dev/null 2>&1 || exit

sed -i 's/o\[\x27libraries\x27] += \[\x27-static\x27]/o\[\x27libraries\x27] += \[\x27-static-pie\x27]/' configure.py

echo -n "Configuring nodejs ... "
./configure $ARGS &> /dev/null
echo ""

echo -n "Building nodejs ... "
make -j"$(nproc)" &> /dev/null
echo ""

popd > /dev/null 2>&1 || exit

ln -fn node-v18.14.0/out/Release/node .

echo "Done"
