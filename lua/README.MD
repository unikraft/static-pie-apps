# Build Lua as static PIE

Build the [Lua](https://www.lua.org/) web server as a static PIE ELF running on Linux.

## Requirements

Make sure the following packages are installed:
* gcc >= 8 (required for the `-static-pie` linking option)
* autotools
* GNU Make
* libreadline-dev package 

For Ubuntu, run the command below to install all requirements:

```
$ sudo apt install build-essential libreadline-dev
```

## Build

The `Lua` static PIE ELF is located in the current folder.
If you want to rebuild it, run:

```
$ ./build.sh
```