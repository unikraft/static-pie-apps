#!/bin/bash

APPNAME=openttd
DIRNAME=OpenTTD
URL=https://github.com/OpenTTD/OpenTTD.git

echo -n "Downloading ${APPNAME} sources ..."
git clone --depth 1 ${URL} --quiet
echo "DONE"

echo -n "Building ${APPNAME} ..."

pushd ${DIRNAME} > /dev/null 2>&1 || exit 1

mkdir build
pushd build > /dev/null 2>&1 || exit 1

cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DOPTION_DEDICATED=ON -DOPTION_USE_ASSERTS=OFF -DOPTION_USE_THREADS=ON ..

echo "target_compile_options(openttd PUBLIC \"-static-pie\")" >> ../CMakeLists.txt
echo "target_compile_options(openttd_lib PUBLIC \"-static-pie\")" >> ../CMakeLists.txt
echo "target_link_options(openttd PUBLIC \"-static-pie\")" >> ../CMakeLists.txt
echo "target_link_options(openttd_lib PUBLIC \"-static-pie\")" >> ../CMakeLists.txt

sed -i 's/link_package/#link_package/g' ../CMakeLists.txt

make -j$(nproc)

strip openttd
strip openttd_test

popd > /dev/null 2>&1 || exit 1

popd > /dev/null 2>&1 || exit 1

