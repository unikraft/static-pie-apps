#!/bin/bash
NODE_VERSION=2.3.7
NODE_URL="https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-$NODE_VERSION.tar.bz2"
rm -rf gnupg-*
LDFLAGS=--static-pie
echo -n "Downloading Node " $NODE_VERSION  "..."
wget -q "$NODE_URL"
rm -rf *lib*
rm -rf npth*
wget -q "https://gnupg.org/ftp/gcrypt/npth/npth-1.6.tar.bz2"
wget -q "https://gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.5.tar.bz2"
wget -q "https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.45.tar.bz2"
wget -q "https://gnupg.org/ftp/gcrypt/libksba/libksba-1.6.0.tar.bz2"
wget -q "https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.10.1.tar.bz2"

tar -xvf npth-1.6.tar.bz2
tar -xvf libassuan-2.5.5.tar.bz2
tar -xvf libgpg-error-1.45.tar.bz2
tar -xvf libksba-1.6.0.tar.bz2
tar -xvf libgcrypt-1.10.1.tar.bz2
echo ""
echo -n "Downloading libgpg-error..... "
pushd libgpg-error-1.45 > /dev/null 2>&1 || exit 1
./configure
make install
popd > /dev/null 2>&1 || exit 1
echo -n "Downloading npth....."
pushd npth1.6 > /dev/null 2>&1 || exit 1
./configure
make install
popd > /dev/null 2>&1 || exit 1
echo -n "Downloading libksba ....."
pushd libksba-1.6.0 > /dev/null 2>&1 || exit 1
./configure
make install
popd > /dev/null 2>&1 || exit 1
echo -n "Downloading libgcrypt......"
pushd libgcrypt-1.10.1 > /dev/null 2>&1 || exit 1
./configure
make install
popd > /dev/null 2>&1 || exit 1
echo -n "Downloading libassuan......"
pushd libassuan-2.5.5 > /dev/null 2>&1 || exit 1
./configure
make install
popd > /dev/null 2>&1 || exit 1
echo -n" Unpacking Node " $NODE_VERSION "...."
tar -xvf gnupg-"$NODE_VERSION".tar.bz2
echo -n "Building Node $NODE_VERSION ..."
pushd gnupg-$NODE_VERSION > /dev/null 2>&1 || exit 1
./configure
make install
popd > /dev/null 2>&1 || exit 1
rm *.html *.tar*
