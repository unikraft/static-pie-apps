# Build zip as static PIE

Build the [zip](https://infozip.sourceforge.net/Zip.html) application as a static PIE ELF running on Linux.

## Requirements

Make sure the following packages are installed:

* GCC
* GNU Make

## Build

The `zip` static PIE ELF file is located in the current directory.
In order to rebuild it you have to run the `build.sh` bash script.
The `build.sh` script will download the `zip` source code, extract it, patch it with the patches present in the `patch/` directory then build the code to generate the static PIE zip binary.

## Running

```bash
./zip 1.zip rootfs/testfile1 rootfs/testfile2
```
