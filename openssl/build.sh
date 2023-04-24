#!/bin/bash

SSL_URL="https://www.openssl.org/source/openssl-3.0.5.tar.gz"
rm -rf SSL-*
echo -n "Downloading OpenSSL ... "
wget -q "$SSL_URL"
echo ""

echo -n "Unpacking OpenSSL ... "
tar xzf openssl-3.0.5.tar.gz
echo ""

pushd openssl-3.0.5 > /dev/null 2>&1 || exit 1

echo -n "Configuring  OpenSSL for static-PIE building..."
./Configure -static
echo ""

echo "Building OpenSSL..."
sed -i "0,/$(BIN_LDFLAGS)/{s/$(BIN_LDFLAGS)[^ ]*/-static-pie/}" Makefile
make -j "$(nproc)"
echo ""

popd > /dev/null 2>&1 || exit 1

ln -fn openssl-3.0.5/apps/openssl .

rm openssl-3.0.5.tar.gz* 