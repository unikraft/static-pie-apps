# Build PHP as static PIE

Build the [PHP](https://www.php.net/) interpreter as static PIE ELF running on Linux

## Requirements

Make sure the following packages are installed:

* gcc >= 8
* GNU Make
* autoconf
* bison
* re2c
* libxml2 development files
* libsqlite3 development files

On Ubuntu, you can install these using:

```
sudo apt install -y pkg-config build-essential autoconf bison re2c \
                        libxml2-dev libsqlite3-dev
```

## Build

The `php` static PIE ELF file is located in the current directory.
In order to rebuild it you have to run the `build.sh` bash script

The scripts downloads, unpack, patches and build the `php` static PIE ELF file.

## Run

In order to run a script using the static PIE php you can pass it as an argument to the ELF file.

