# Built Apps

This is a repository of built/configured Linux applications to be used with the Unikraft ELF Loader, i.e. in binary-compatibility mode.
Currently, to be loader and run with Unikraft, ELF files must be compiled with `-static-pie` option (available for GCC >= 8).

Build files (such as Makefiles) are updated for each application to use the `-static-pie` flag.
See the corresponding folder for each application or application folder.

Generally, each application or application folder consists of a `build.sh` script to build applications as static PIE executables.

Apart from updates to the build system (generally provided as a patch), applications may feature a `rootfs/` folder that is used to populate the root filesystem for the ELF loader.

The best way to use these applications is via the [`run_elfloader` script](https://github.com/unikraft/run-app-elfloader).
