#!/bin/bash

APPNAME=nats
DIRNAME=nats-server
URL=https://github.com/nats-io/nats-server.git

# Clean up
# rm -rf ${DIRNAME}

echo -n "Downloading ${APPNAME} sources ... "
git clone ${URL} --quiet
# if test $? -ne 0; then
#     echo ""
#     echo "Unable to to clone git from ${URL}"
#     exit 1
# fi
echo "DONE"

echo ""
echo -n "Building ${APPNAME} ... "
pushd ${DIRNAME} > /dev/null 2>&1 || exit 1

go build -buildmode=pie -ldflags "-linkmode external -extldflags "-static-pie"" -tags netgo
mv nats-server ..

popd > /dev/null 2>&1 || exit 1

# rm -rf ${DIRNAME}

echo "Build complete!"
