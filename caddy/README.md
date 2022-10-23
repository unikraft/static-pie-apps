# Build caddy server as static PIE

Build the [caddy server](https://caddyserver.com/) web server as a static PIE ELF running on Linux.

## Requirements

Make sure the following packages are installed:
* go >= 1.17

## Build

The `caddy` static PIE ELF is located in the current folder.
If you want to rebuild it, run:

```
$ ./build.sh
```

## Run

You can run the executable natively on Linux:

```
$ ./caddy-2.6.2/cmd/caddy/caddy respond --debug --access-log --listen :8089 "Hello world\!"
```

Or with [run-elfloader](https://github.com/unikraft/run-app-elfloader) on Unikraft:
```
$ ./run_elfloader ../static-pie-apps/caddy/caddy-2.6.2/cmd/caddy/caddy [args]
```

