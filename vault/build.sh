#!/bin/bash


# Clean up.
rm -fr vault-*

echo -n "Downloading vault ... "
git clone https://github.com/hashicorp/vault
echo "Configuring vault ... "

pushd vault > /dev/null 2>&1 

echo "Configuring vault ... "
sudo apt remove --autoremove golang
wget https://go.dev/dl/go1.20.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf ./go1.20.2.linux-amd64.tar.gz
sudo sh -c 'echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile'
go version


pwd
make bootstrap
make dev



echo -n "Building vault ... "

popd > /dev/null 2>&1 || exit
