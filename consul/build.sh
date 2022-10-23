#!/bin/sh

# Clean up
rm -rf consul-*
rm -f v1.*

echo "Downloading consul source code... "
wget -q https://github.com/hashicorp/consul/archive/refs/tags/v1.13.3.zip

echo "Unpacking consul source code..."
unzip v1.13.3.zip

echo "Building consul... "
cd consul-1.13.3 || exit
patch GNUmakefile ../GNUmakefile.patch
make linux
echo ""
