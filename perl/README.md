# Miniperl

Build the gzip data compressor as a static PIE ELF running on Linux.

## Requirements
Make sure the following packages are installed:
- gcc >= 8 (required for the -static-pie linking option)
- git
- GNU Make

## Building
The miniperl static PIE ELF file is located in the current directory. If you want to rebuild it, run:

'''bash
$ ./build.sh
'''

This script downloads, unpacks, patches, configures and builds the gzip static PIE ELF file.
