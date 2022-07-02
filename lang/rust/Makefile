.PHONY: all clean

all: helloworld-musl helloworld-gnu

# musl targets are `crt-static` by default
# See https://doc.rust-lang.org/reference/linkage.html#static-and-dynamic-c-runtimes

# `-C link-arg=-static-pie` is implied by `crt-static`
# See https://doc.rust-lang.org/rustc/codegen-options/index.html?highlight=static-pie#relocation-model

helloworld-musl: helloworld.rs
	rustc --target x86_64-unknown-linux-musl -o helloworld-musl $<

helloworld-gnu: helloworld.rs
	rustc -C target-feature=+crt-static --target x86_64-unknown-linux-gnu -o helloworld-gnu $<

clean:
	-rm -f helloworld-musl helloworld-gnu
