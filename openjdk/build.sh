#!/bin/bash

# Clean.
if [[ $@ == "clean" ]]; then \
	echo "Cleaning up ..."
	rm -rf jdk out 2> /dev/null
	echo ""
fi

# Clone OpenJDK.
if [ ! -d jdk ]; then \
	echo "Cloning OpenJDK ..."
	git clone https://github.com/openjdk/jdk.git
	echo ""
fi

# Create out dir.
if [ ! -d out ]; then \
	mkdir out
fi

# Configure
echo "Configuring OpenJDK ... "
C_DIR=$PWD

pushd jdk > /dev/null 2>&1 || exit 1

bash configure --prefix="$C_DIR/out" --with-extra-ldflags="-static-pie"
echo ""

popd > /dev/null 2>&1 || exit 1
