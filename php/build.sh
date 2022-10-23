#!/bin/bash

PHP_VERSION=8.1.11
PHP_URL="https://www.php.net/distributions/php-$PHP_VERSION.tar.gz"

#clean up
rm -rf php-*

echo -n "Downloading PHP $PHP_VERSION ... "
wget -q "$PHP_URL"
echo ""

echo -n "Unpacking PHP $PHP_VERSION ... "
tar xzf php-$PHP_VERSION.tar.gz
echo ""

pushd php-$PHP_VERSION > /dev/null 2>&1 || exit 1

echo "Configuring PHP $PHP_VERSION ... "
#iconv and opcache seem to have problems with being in a static build
CFLAGS=-fPIC ./configure
#patch the Makefile
sed -e '/^BUILD_C/s/ -export-dynamic//g' -e 's/^EXTRA_LIBS = .*/EXTRA_LIBS = -lrt -lxml2 -lsqlite3 -lz -llzma -licuuc -licudata -lstdc++ -lm/g' -e '/^EXTRA_LDFLAGS_PROGRAM/s/$/ -static-pie/g' -i Makefile
echo ""

echo "Building PHP $PHP_VERSION ... "
make -j "$(nproc)"
popd > /dev/null 2>&1 || exit 1

ln -fn php-$PHP_VERSION/sapi/cli/php .

rm -rf php-*
