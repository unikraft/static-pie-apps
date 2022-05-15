CXX = g++

# compiler flags:
#  -g     - this flag adds debugging information to the executable file
#  -Wall  - this flag is used to turn on most compiler warnings
CFLAGS  = -g -Wall -fPIC
LDFLAGS = -static-pie

# The build target 
.PHONY: all clean

all: helloworld

helloworld: helloworld.o

helloworld.o: helloworld.cpp

clean:
	-rm -f helloworld
	-rm -f *~

