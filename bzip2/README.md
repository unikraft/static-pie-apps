# Build bzip2 as static PIE

Build the [bzip2](http://sourceware.org/bzip2/) as static PIE ELF running on Linux

## Requirements

Make sure the following packages are installed:

* GCC
* GNU Make

## Build

The `bzip2` static PIE ELF file is located in the current directory.
In order to rebuild it you have to run the build.sh bash script

The scripts downloads, unpack, patches and build the `bzip2` static PIE ELF file.

## Running

```
./bzip2 rootfs/compress_me
./bzip2 -d rootf/decompress_me.bz2
```
