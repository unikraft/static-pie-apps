# Build node as static PIE

Build the [node](https://nodejs.org/en) javascript runtime environments as a static PIE ELF running on Linux.

## Requirements

Make sure the following packages are installed:
* gcc and g++ >= 10.1 or newer
* GNU Make 3.81 or newer
* Python >=3.6 <=3.11

For Ubuntu, run the command below to install all requirements:

```
$ sudo apt install build-essential python3
```

## Build

The `node` static PIE ELF is located in the current folder.
If you want to rebuild it, run:

```
$ ./build.sh
```

Because github has a 150Mb per file limit and the resulting executable
has 161MB, you can get the executable from [here](https://drive.google.com/file/d/1UVGvyZ1qiiesfm7eRwHhjDam9Jj5f8cH/view?usp=sharing).
