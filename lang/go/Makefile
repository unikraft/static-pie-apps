.PHONY: all clean

GO = /usr/bin/go

all: server client helloworld

server: server.go
	$(GO) build -buildmode=pie -ldflags "-linkmode external -extldflags "-static-pie"" -tags netgo $<

client: client.go
	$(GO) build -buildmode=pie -ldflags "-linkmode external -extldflags "-static-pie"" -tags netgo $<

helloworld: helloworld.go
	$(GO) build -buildmode=pie -ldflags "-linkmode external -extldflags "-static-pie"" -tags netgo $<

clean:
	-rm -f helloworld server client
	-rm -f *~
