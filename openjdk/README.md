# Building OpenJDK as static PIE

Build the [OpenJDK](https://openjdk.org/)(v20) as a static PIE ELF.

## Requirements:

Make sure the following packages are installed:
* gcc >= 8
* autoconf
* zip
* alsa
* cups
* fontconfig
* X11
* JDK v19

## Build

If you want to build `OpenJDK`, run:

```
$ bash build.sh
```

This will create a directory named 'out' where the `OpenJDK` will be located.

If you want to clean everything and rebuild it, run:

```
$ bash build.sh clean
```
