# Build ffmpeg as static PIE

Script to build ffmpeg as a static PIE binary.

## Requirements

Make sure that you have the following packages installed:
* GCC
* GNU Make

## Build

Run the build.sh file.
It will create a static PIE ffmpeg binary in the current folder.

## Running

```bash
./ffmpeg -i rootfs/drop.avi drop_new.mp4
```