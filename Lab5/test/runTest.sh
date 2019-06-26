#! /bin/bash

g++ ../src/simulate_caches.cpp
./a.out $1 output.out
rm a.out
