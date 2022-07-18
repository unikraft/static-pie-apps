CFLAGS = -Wall -fPIC
DFLAGS = $(CFLAGS)
LDFLAGS = -static-pie
DC = gdc

.PHONY: all clean

helloworld: helloworld.o dummy.o
	$(DC) $(LDFLAGS) -o $@ $^

%.o : %.d
	$(DC) $(CFLAGS) -c $< -o $@

helloworld.o: helloworld.d

dummy.o: dummy.c

clean:
	-rm -f helloworld helloworld.o dummy.o
	-rm -f *~
