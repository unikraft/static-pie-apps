NODE_VERSION = 18.15.0
NODE_SOURCE_CODE_URL = https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.gz

.PHONY: prepare clean node-gnu node-musl

prepare:
	# get source code
	rm -rf node-v${NODE_VERSION}
	if [ ! -e "node-v${NODE_VERSION}.tar.gz" ]; then wget $(NODE_SOURCE_CODE_URL); fi
	tar zxf node-v${NODE_VERSION}.tar.gz
	# patch build commands
	sed -i "s/'-static'/'-static-pie', '-fPIC'/" node-v${NODE_VERSION}/configure.py

node-gnu: prepare
	# build node
	cd node-v${NODE_VERSION} && ./configure --fully-static --enable-static
	cd node-v${NODE_VERSION} && make -j`nproc`
	# archive node with static-pie
	cp node-v${NODE_VERSION}/out/Release/node ./node-gnu

node-musl: prepare
	# prepare node-musl
	mkdir node-musl-toolchain && cd node-musl-toolchain && npm i node-musl
	# build node
	cd node-v${NODE_VERSION} && ../node-musl-toolchain/node_modules/.bin/musl-env ./configure --fully-static --enable-static
	cd node-v${NODE_VERSION} && ../node-musl-toolchain/node_modules/.bin/musl-env make -j`nproc`
	# archive node with static-pie
	cp node-v${NODE_VERSION}/out/Release/node ./node-musl

test-gnu:
	./node-gnu helloworld.js

test-musl:
	./node-musl helloworld.js

clean:
	rm -rf node-v${NODE_VERSION}
	rm -rf node-v${NODE_VERSION}.tar.gz
	rm -rf node-musl-toolchain
