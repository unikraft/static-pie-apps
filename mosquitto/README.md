# Build mosquitto as static PIE

Build the [Mosquitto](https://www.python.org/) broker as a static PIE ELF running on Linux.

## Requirements

Make sure the following packages are installed:
* GCC
* GNU Make
* c-ares (libc-ares-dev on Debian based systems) - only when compiled with `make WITH_SRV=yes`
* cJSON - for client JSON output support. Disable with `make WITH_CJSON=no`
* libwebsockets (libwebsockets-dev) - enable with `make WITH_WEBSOCKETS=yes`
* openssl (libssl-dev on Debian based systems) - disable with `make WITH_TLS=no`
* pthreads - for client library thread support. This is required to support the 
  `mosquitto_loop_start()` and `mosquitto_loop_stop()` functions. If compiled   
  without pthread support, the library isn't guaranteed to be thread safe.         
* uthash / utlist - bundled versions of these headers are provided, disable their use with `make WITH_BUNDLED_DEPS=no`
* xsltproc (xsltproc and docbook-xsl on Debian based systems) - only needed when building from git sources - disable with `make WITH_DOCS=no`

All the above environment variables can be changed in build.sh
                
                                                                                
## Build

The `mosquitto` static PIE ELF file is located in the current folder.
If you want to rebuild it, run:

```
$ ./build.sh
```

## Running


```
$ ./mosquitto
```

