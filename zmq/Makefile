LDFLAGS = -static-pie
CXX = g++
CC = gcc
CFLAGS = -Wall -Wextra -Wno-unused -Wno-unused-parameter -g
LDLIBS = -lpthread -lbsd -lstdc++

CLIENT_BIN = client
SERVER_BIN = server

.PHONY: all clean

all: $(CLIENT_BIN) $(SERVER_BIN)

$(CLIENT_BIN): $(CLIENT_BIN).o libzmq.a

$(CLIENT_BIN).o: $(CLIENT_BIN).c

$(SERVER_BIN): $(SERVER_BIN).o libzmq.a

$(SERVER_BIN).o: $(SERVER_BIN).c

clean:
	-rm -f $(CLIENT_BIN) $(CLIENT_BIN).o
	-rm -f $(SERVER_BIN) $(SERVER_BIN).o
	-rm -f *~
