.PHONY: all clean

all:
	gm2 -fPIC -static-pie hello.mod -o hello
	-rm -f hello.o
	-rm -f hello_m2.o

clean:
	-rm -f hello.o hello_m2.o hello
