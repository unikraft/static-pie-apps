.PHONY: all clean

all: hello-no-std

hello-no-std: hello-no-std.rs
	rustc --target x86_64-unknown-none $<

clean:
	-rm -f hello-no-std
