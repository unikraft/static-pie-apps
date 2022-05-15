CFLAGS = -Wall -fPIC
LDFLAGS = -static-pie

.PHONY: all clean

all: server client helloworld

server: server.o

server.o: server.c

client: client.o

client.o: client.c

helloworld: helloworld.o

helloworld.o: helloworld.c

clean:
	-rm -f helloworld server client
	-rm -f *~
