# Build the helloworld example for dlang

Build the `helloworld.d` file to a static PIE ELF running on Linux.

## Requirements

Make sure the following dependencies are installed:

* GCC (for compiling C files and for GDC)
* GNU Make
* GDC (for compiling D source files and for linking)
* Phobos Runtime Library (should be installed by default with GDC)

For Debian based distros, run the command below to install all requirements:

```
$ sudo apt install build-essential gdc
```

For other systems, follow the [online guide for installing GDC](https://wiki.dlang.org/GDC/Installation).

## Build

The `helloworld` static PIE ELF file is located in the current folder.
To rebuild it run:

```
$ make helloworld
```

This compiles the `helloworld.d` and `dummy.c` as PIC(*Position Independent Code*) object files. Then, it statically links them with the needed libraries as PIE (*Position Independent Executable*). 
