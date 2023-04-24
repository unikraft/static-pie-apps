# Build unzip as static PIE

Build the [unzip](https://infozip.sourceforge.net/UnZip.html) application as static PIE ELF running on Linux.

## Requirements

Make sure the following packages are installed:

* GCC
* GNU Make

## Build

The `unzip` static PIE ELF file is located in the current directory.
In order to rebuild it you have to run the `build.sh` bash script.
The `build.sh` script will download, extract, patch and build the code to generate the static PIE unzip binary.

## Running

```bash
./unzip extract.zip
```
