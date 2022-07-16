# Build ZeroMQ server and client as static PIE

Simple client and server applications using the [ZeroMQ library](https://github.com/zeromq/libzmq) as a static PIE ELF running on Linux.

## Requirements

Make sure the following packages are installed:

* `GCC`
* `G++`
* `GNU Make`
* `libbsd-dev`

For Debian-based systems, run the command below to install all requirements:

```console
$ sudo apt install sudo apt install gcc g++ make libbsd-dev
```

## Build

The `server` and `client` static PIE ELF files are located in the current folder.
If you want to rebuild it, run:

```console
$ ./build.sh
```

This script downloads, unpacks, configures and builds the `ZeroMQ` library and then builds the `server` and `client` apps.

## Running

To run the app locally, use, on two different consoles:

```console
$ ./server

$ ./client 0.0.0.0
```

The output should look something like:

```text
--SERVER--
Received Hello
Received Hello
Received Hello


--CLIENT--
Connecting to hello world server...
Sending Hello 0...
Received World 0
Sending Hello 1...
Received World 1
Sending Hello 2...
```
