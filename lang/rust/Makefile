all: helloworld

helloworld: helloworld.rs:
	rustc -C link-args=-fPIC --target x86_64-unknown-linux-musl $<
