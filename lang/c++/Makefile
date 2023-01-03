CXXFLAGS = -g -Wall -fPIC
LDLIBS = -lstdc++
LDFLAGS = -static-pie

.PHONY: all clean

all: helloworld

helloworld: helloworld.o

helloworld.o: helloworld.cpp

clean:
	-rm -f helloworld helloworld.o
	-rm -f *~
