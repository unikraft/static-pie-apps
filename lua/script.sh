#!/bin/bash

rm -rf *lua
git clone https://github.com/lua/lua

diff -u lua/makefile patches/makefile.patch > patch.diff

patch lua/makefile < patch.diff

rm patch.diff

