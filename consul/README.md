# Build consul server as static PIE

Build the consul server as a static PIE ELF running on Linux.

## Requirements

Make sure the following packages are installed:
* go >= 1.17
* unzip
* patch

## Build

The `consul` static PIE ELF is located in the current folder.
If you want to rebuild it, run:

```
$ ./build.sh
```

## Run

You can run the executable natively on Linux:

```
$ ./consul-1.13.3/pkg/bin/consul version
```

Or with [run-elfloader](https://github.com/unikraft/run-app-elfloader) on Unikraft:
```
$ ./run_elfloader ../static-pie-apps/consul/consul-1.13.3/pkg/bin/consul [args]
```
