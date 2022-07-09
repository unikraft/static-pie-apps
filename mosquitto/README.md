# Build mosquitto as static PIE

Build the [Mosquitto](https://www.python.org/) broker as a static PIE ELF running on Linux.

## Requirements

Make sure the following packages are installed:
* GCC
* GNU Make
* c-ares (libc-ares-dev on Debian based systems).
* cJSON - for client JSON output support.
* libwebsockets (libwebsockets-dev).
* openssl (libssl-dev on Debian based systems).
* pthreads - for client library thread support. If compiled without pthread support, the library isn't guaranteed to be thread safe.         
* uthash / utlist - bundled versions of these headers are provided.
* xsltproc (xsltproc and docbook-xsl on Debian based systems) - only needed when building from git sources - disable with `make WITH_DOCS=no`
                                                                                
## Build

The `python` static PIE ELF file is located in the current folder.
If you want to rebuild it, run:

```
$ ./build.sh
```

## Running

To run the `python` binary, you need to specifiy where it can find the `Lib`
folder. This can be done by setting the `PYTHONPATH` variable. The `Lib` folder
is normally found in the source files. Here, there is also in the `rootfs`
folder. Therefore, to run the binary, you can do this:

```
$ PYTHONPATH=$PWD/rootfs/Lib ./python
```

If you rebuilt the python binary with a new version of python, you may need to
replace the Lib folder from rootfs with the new version.
