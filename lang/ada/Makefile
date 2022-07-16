
GARB= hello.ali hello.o

ADARGS= -fPIC -W -distcc -pie

ADACOMPILE = gnatmake

LDARGS= -largs -static-pie -bargs -static
all: hello

hello: hello.adb
	$(ADACOMPILE) $(ADARGS) $^ $(LDARGS)
	rm -f $(GARB)
clean:
	rm -f hello
