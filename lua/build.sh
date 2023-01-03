#!/bin/bash

LUA_VERSION=5.4.4
LUA_URL="http://www.lua.org/ftp/lua-$LUA_VERSION.tar.gz"


rm -rf lua-*

echo -n "Downloading Lua $LUA_VERSION... "
wget -q "$LUA_URL"

echo ""
echo -n "Unpacking Lua $LUA_VERSION ... "
tar xzf lua-$LUA_VERSION.tar.gz

pushd lua-$LUA_VERSION/src > /dev/null 2>&1 || exit 1
echo -n "Patching Lua build files... "
patch -p1 < ../../patches/0001-Add-proper-flags.patch

echo -n "Building Lua $LUA_VERSION ... "
make 

popd > /dev/null 2>&1 || exit 1

ln -fn lua-$LUA_VERSION/src/lua .
ln -fn lua-$LUA_VERSION/src/luac .

rm -rf lua-*
