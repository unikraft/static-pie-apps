#!/bin/bash

# "Cleanup directory"
rm -fr postgresql-*

# "Download Postgres"
wget https://ftp.postgresql.org/pub/source/v15.0/postgresql-15.0.tar.gz

# "Unpacking postgreSQL"
tar -xf postgresql-15.0.tar.gz

pushd postgresql-15.0 > /dev/null 2>&1 
echo "Entering folder and configuring postgreSQL"
patch src/bin/psql/Makefile < ../makefile.patch
mkdir build
./configure --prefix=$(pwd)/build --without-readline --without-zlib CFLAGS='-fPIC' LDFLAGS_EX='-static-pie'
# "Building PostgreSQL"
make
popd > /dev/null 2>&1

ln -fn $(pwd)/postgresql-15.0/src/bin/psql/psql
