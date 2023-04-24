#!/bin/bash

link="https://ffmpeg.org/releases/ffmpeg-5.1.2.tar.bz2"

# Clean up
rm -fr ffmpeg-*

echo -n "Downloading ffmpeg source code ... "
wget -q "$link"
echo ""
echo -n "Unpacking ffmpeg ... "
tar -xf ffmpeg-5.1.2.tar.bz2
echo ""

pushd ffmpeg-5.1.2/ > /dev/null 2>&1 || exit 1

echo -n "Configuring ffmpeg ... "
# Add PIC/PIE compile/link flags.
./configure --extra-cflags="-fPIC" --extra-ldflags="-static-pie"  --disable-shared --disable-opencl
echo ""

echo -n "Building ffmpeg ..."
make -j "$(nproc)"

echo ""
popd > /dev/null 2>&1 || exit

ln -fn ffmpeg-5.1.2/ffmpeg .

rm ffmpeg-5.1.2.tar.bz2*