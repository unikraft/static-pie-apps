FORTRAN= /usr/bin/gfortran

FFLAGS= -Wall -fPIC

LDFLAGS = -static-libgfortran

all: helloworld

helloworld: helloworld.f90
	$(FORTRAN) $(FFLAGS) $^ -o $@ $(LDFLAGS)
