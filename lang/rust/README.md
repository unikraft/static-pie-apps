# Rust

This is Rust's default "Hello World" application compiled for the following targets:
* `x86_64-unknown-linux-musl`
* `x86_64-unknown-linux-gnu`

## Requirements

* The GNU target requires Rust 1.60.0 to support `static-pie`: https://github.com/rust-lang/rust/pull/86374
  * Your distro's packages might not be recent enough.
* The musl target is not installed by default on other hosts.

[Install Rust using rustup](https://www.rust-lang.org/tools/install) to be able to use a recent enough Rust toolchain.
Make sure you are using the latest version:

```
$ rustup update
$ rustup default stable
```

To install the musl target, run:

```
$ rustup target add x86_64-unknown-linux-musl
```
