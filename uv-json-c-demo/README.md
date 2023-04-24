# LibUV JSON-C demo
A [demo app](https://github.com/andreiosg/hello-unikernel) statically linked with the LibUV and JSON-C libraries.
Build it as a static PIE ELF running on Linux.

## Requirements
Make sure all of the following are installed:

- `gcc` >= 8 (required for `-static-pie` linking)
- `cmake`
- `make`
- `git`

To install the dependencies on Arch Linux:
```
# pacman -S gcc cmake make git
```

## Building
To build run:

```
./autogen.sh
```

The script always starts after a cleanup.
