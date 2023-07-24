# OpenTTD-Server

Build the openttd-server dedicated as a static PIE ELF running on Linux.

## Requirements
Make sure the following packages are installed:
- build-utils
- cmake
- git
- strip

## Building
The openttd and openttd_test static PIE files are located in the current directory.
If you want to rebuild, run:

```bash
$ ./build.sh
```

This script downloads, unpacks, patches, configures, and builds the openttd dedicated server PIE ELF file.
Make sure that you patch out any other libraries that you might have in your system.
If you want to add a library, add this type of line after the `sed` command:

```
set(ZLIB_USE_STATIC_LIBS "ON")
```
