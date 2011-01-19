#!/bin/sh
g++ -ggdb `pkg-config --cflags opencv` -o `basename detectface .cpp` detectface.cpp `pkg-config --libs opencv`;
gcc -ggdb `pkg-config --cflags opencv` -o `basename eigen .c` eigen.c `pkg-config --libs opencv`;
g++ -ggdb `pkg-config --cflags opencv` -o `basename detectperson .cpp` detectperson.cpp `pkg-config --libs opencv`;
