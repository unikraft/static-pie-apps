# Build HAProxy as static PIE

Build the [HAProxy](https://git.haproxy.org/): The Reliable, High Performance TCP/HTTP Load Balancer as a static PIE ELF running on Linux.

## Requirements

Make sure the following packages are installed:
* gcc >= 8 (required for the `-static-pie` linking option)
* autotools
* GNU Make
* zlib development files
* OpenSSL development files

For Ubuntu, run the command below to install all requirements:

```
$ sudo apt install build-essential zlib1g-dev libssl-dev
```

## Build

The `HAProxy` static PIE ELF is located in the current folder.
If you want to rebuild it, run:

```
$ ./build.sh
```