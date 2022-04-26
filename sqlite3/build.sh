#!/bin/bash

# Clean up.
rm -fr sqlite-amalgamation-*

echo -n "Downloading sqlite3 amalgamation ... "
wget -q https://www.sqlite.org/2022/sqlite-amalgamation-3380200.zip
echo ""
echo -n "Unpacking sqlite 3 ... "
unzip -q -o sqlite-amalgamation-3380200.zip
echo ""
echo -n "Building sqlite 3 ... "
pushd sqlite-amalgamation-3380200 > /dev/null 2>&1
gcc -Wall -fPIC -static-pie -o sqlite3 *.c -ldl -lpthread
popd > /dev/null 2>&1

ln -fn sqlite-amalgamation-3380200/sqlite3 .
