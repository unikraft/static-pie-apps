#!/bin/bash

APPNAME=miniperl
DIRNAME=perl5
URL=https://github.com/perl/perl5

# Clean up
rm -rf ${DIRNAME}

echo -n "Downloading ${APPNAME} sources ... "
git clone ${URL} --quiet
if test $? -ne 0; then
    echo ""
    echo "Unable to to clone git from ${URL}"
    exit 1
fi
echo "DONE"

echo ""
echo -n "Building ${APPNAME} ... "
pushd ${DIRNAME} > /dev/null 2>&1 || exit 1

./Configure -des
make minitest

rm generate_uudmap.o
gcc $(ls | grep "\.o$") -lm -lcrypt -static-pie -o miniperl
mv miniperl ..

popd > /dev/null 2>&1 || exit 1

rm -rf ${DIRNAME}

echo "Build complete!"
