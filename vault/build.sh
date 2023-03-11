#!/bin/bash

# Clean up.
rm -fr vault-*

echo -n "Downloading Vault ... "
wget -q https://releases.hashicorp.com/vault/1.8.1/vault_1.8.1_linux_amd64.zip
echo ""

echo -n "Unpacking Vault ... "
unzip vault_1.8.1_linux_amd64.zip
echo ""

pushd vault_1.8.1 > /dev/null 2>&1 || exit

echo "Configuring Vault ... "

# Add PIC/PIE compile/link flags.
# Disable UI and telemetry to reduce binary size and avoid network requests.
make bootstrap UI=""
./configure --with-cc-opt="-fPIC" --with-ld-opt="-static-pie" --disable-telemetry

# Remove linker flag to export dynamic symbols.
# This causes a static PIE ELF to crash.
sed -i '/-Wl,-E/d' Makefile

echo -n "Building Vault ... "
make -j "$(nproc)"
popd > /dev/null 2>&1 || exit

ln -fn vault_1.8.1/vault .
