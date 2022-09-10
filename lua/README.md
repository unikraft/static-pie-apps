# Build Lua as static PIE

Build the [Lua](https://www.lua.org/) interpreter and compiler as static PIE ELF running on Linux

## Requirements

Make sure the following packages are installed:

* GCC
* GNU Make

## Build

The `lua` and `luac` static PIE ELF files are located in the current directory.
In order to rebuild them you have to run the build.sh bash script

The scripts downloads, unpack, patches and build the `lua` and `luac` static PIE ELF files.

## Running

In order to run a script using the static PIE lua you can pass it as an argument to the ELF file

```
./lua helloworld.lua
```

