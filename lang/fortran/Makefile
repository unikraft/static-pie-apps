FORTRAN= /usr/bin/gfortran

FFLAGS= -Wall -fPIC -pie -distcc

LDFLAGS = --static-pie -static-libgcc

all: helloworld

helloworld: helloworld.f90
	$(FORTRAN) $(FFLAGS) $^ -o $@ $(LDFLAGS)
clean:
	rm -f helloworld
