# Build OpenSSL as static PIE

Script to build OpenSSL as a static PIE ELF binary. 

## Requirements

Make sure that you have the following packages:
* GCC
* GNU Make

## Build

Run the build.sh file.
It will create a folder where the static PIE OpenSSL will be located.

## Running

### Encrypt 

```bash
./openssl aes-256-cbc  -a -salt -pbkdf2 -pass pass:PASSWORD -in rootfs/plaintext.txt -out rootfs/ciphertext.enc
```

### Decrypt

```bash
./openssl aes-256-cbc  -d -a -salt -pbkdf2 -pass pass:PASSWORD -in  rootfs/ciphertext.enc
```