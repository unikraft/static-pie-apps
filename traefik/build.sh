#!/bin/bash

version=v2.10.3
name=traefik
appname=${name}-${version}
tarball=${appname}.src.tar.gz

echo "Cleaning artefacts ..."
rm -rf ${tarball} ${appname} ${name}

echo -n "Downloading ${tarball} ... "
wget -q https://github.com/traefik/traefik/releases/download/${version}/${tarball}
echo ""

echo -n "Unpacking traefik ... "
mkdir -p ./$appname
tar xzf $tarball -C ./$appname
echo ""

echo -n "Setting up GO env ... "
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
echo ""

#echo -n "Building traefik ... "
#make clean-webui -C ${appname}
#echo ""

pushd ${appname}

echo "${appname}: Running GO get ..."
go get &&
go mod tidy &&
go generate &&
go build -buildmode=pie \
    -ldflags "-linkmode 'external' -extldflags '-static-pie'" \
    -tags netgo \
    ./cmd/traefik

popd +0

if test -f ${appname}/${name}; then
    ln -s ${appname}/${name} ./${name}
fi
