# Nats-server

Build the nats-server as a static PIE ELF running on Linux.

## Requirements
Make sure the following packages are installed:
- go
- git

## Building
The nats-server static PIE ELF file is located in the current directory. If you want to rebuild it, run:

'''bash
$ ./build.sh
'''

This script downloads, unpacks, patches, configures and builds the nats-server static PIE ELF file.
