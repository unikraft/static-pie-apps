#!/bin/bash

# Clean up.
rm -fr nginx-*

echo -n "Downloading nginx ... "
wget -q http://nginx.org/download/nginx-1.22.0.tar.gz
echo ""

echo -n "Unpacking nginx ... "
tar xzf nginx-1.22.0.tar.gz
echo ""

pushd nginx-1.22.0 > /dev/null 2>&1 || exit

echo "Configuring nginx ... "

# Add PIC/PIE compile/link flags.
# Remove libpcre to fix static library dependency issue with libphtreads.
./configure --with-cc-opt="-fPIC" --with-ld-opt="-static-pie" --without-pcre --without-http_rewrite_module

# Remove linker flag to export dynamic symbols.
# This causes a static PIE ELF to crash.
sed -i '/\-Wl,\-E/d' objs/Makefile

echo -n "Building nginx ... "
make -j "$(nproc)"
popd > /dev/null 2>&1 || exit

ln -fn nginx-1.22.0/objs/nginx .
