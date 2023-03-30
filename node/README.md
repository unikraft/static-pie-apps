# Build Node.js as static PIE

Build the [Node.js](https://nodejs.org/) as a static PIE ELF running on Unikraft.

## Requirements

Make sure the following packages are installed:
* gcc >= 8.3.0
* autotools
* GNU Make
* npm

## Build

The `node-gnu` and `node-musl` static PIE ELF files are placed in the current folder.

Run the following command to rebuild them, the build cache will be automatically removed.

```console
$ make node-gnu
$ make node-musl
```

## Test

A simple server program is provided for testing.
When accessed through a browser, it shows the message 'Hello World from Unikraft!'.

Run the following command to try it:

```console
$ make test-gnu
$ make test-musl
```
