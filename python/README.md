# Build Python as static PIE

Build the [Python](https://www.python.org/) interpreter as a static PIE ELF running on Linux.

## Requirements

Make sure the following packages are installed:

* GCC
* GNU Make
* OpenSSL

For Debian-based systems, run the command below to install all requirements:

```
$ sudo apt install build-essential libssl-dev
```

## Build

The `python` static PIE ELF file is located in the current folder.
If you want to rebuild it, run:

```
$ ./build.sh
```

This script downloads, unpacks, patches, configures and builds the `python` static PIE ELF file.
It also builds the `rootfs.tar` archive with the required libraries.

## Running

To run the `python` static binary, you need to unpack the `rootfs.tar` archive:

```
$ tar xf rootfs.tar
```

This creates the `rootfs/` folder that stores the libraries required for running Python.

To run Python, pass the `rootfs/` folder in Python environment variables:

```
$ PYTHONHOME=$PWD/rootfs/ PYTHONPATH=$PWD/rootfs/ ./python
```
