#!/bin/bash

rm -rf ./*lua*
git clone https://github.com/lua/lua

cp makefile ./lua || return

cd lua || exit 
make

