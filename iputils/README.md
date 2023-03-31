# iputils

Build the [iputils](https://github.com/iputils/iputils/) set of tools as static PIE ELF binaries running on Linux.

## Requirements

Make sure the following packages are installed:
* gcc >= 8 (required for the `-static-pie` linking option)
* autotools
* meson
* GNU Make

For Debian, run the command below to install all requirements:

```bash
$ sudo apt install build-essential
export DEBIAN_FRONTEND="noninteractive"

apt update

apt install -y --no-install-recommends \
	clang \
	docbook-xsl-ns \
	file \
	gcc \
	gettext \
	iproute2 \
	libcap-dev \
	libidn2-0-dev \
	libssl-dev \
	make \
	meson \
	pkg-config \
	xsltproc

```

## Building

The static PIE ELF file are located in the current directory.
If you want to rebuild them, run:

```bash
$ ./build.sh
```

This script downloads, unpacks, patches, configures and builds the tools.

## Running

The resulting binaries can be used as is.
For example, you can ping an address by issuing the command:

```bash
$ ./ping 1.1.1.1
```

## Issues

1. When running in KVM with LWIP you can't use RAW sockets because they're not
   available by default. See this for more information:
   https://github.com/unikraft/lib-lwip/pull/2

2. There is a bug in LWIP where normal sockets (not RAW) that use ICMP protocol
   are sent using UDP protocol instead. See https://github.com/unikraft/lib-lwip/issues/32
