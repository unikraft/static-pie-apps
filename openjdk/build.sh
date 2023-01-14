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
	git clone --depth 1 https://github.com/openjdk/jdk.git
	echo ""
fi

# Create out dir.
if [ ! -d out ]; then \
	mkdir out
fi

# Configure
echo "Configuring OpenJDK ... "
C_DIR=$PWD
JDK_DIR=$PWD/jdk

pushd jdk > /dev/null 2>&1 || exit 1

git apply $C_DIR/patches/static-pie.patch
bash configure --prefix="$C_DIR/out" --with-num-cores=$(nproc) --with-x=no --enable-static-build --enable-headless-only=yes
echo ""

# Build
echo "Building OpenJDK ... "
JOBS=$(nproc) LOG=info,cmdlines make images

# The build is expected to fail when trying to create the java executable
# So, we run the command manually:
echo "Creating the executable ... "
gcc -Wl,-z,defs -Wl,-z,relro -Wl,-z,now -Wl,-z,noexecstack -Wl,-O1 -m64 -Wl,--allow-shlib-undefined -static-pie -Wl,--exclude-libs,ALL -Wl,-rpath,\$ORIGIN -Wl,-rpath,\$ORIGIN/../lib \
	-L$JDK_DIR/build/linux-x86_64-server-release/support/modules_libs/java.base \
	-o $JDK_DIR/build/linux-x86_64-server-release/support/modules_cmds/java.base/java \
	$JDK_DIR/build/linux-x86_64-server-release/support/native/java.base/java/main.o \
	-ljli \
	/lib/x86_64-linux-gnu/libz.a

ln -fn $JDK_DIR/build/linux-x86_64-server-release/support/modules_cmds/java.base/java $PWD

popd > /dev/null 2>&1 || exit 1
