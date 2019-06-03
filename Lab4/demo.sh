#! /bin/bash

make > /dev/null

cd source_code/verilog && ./a.out > /dev/null && cd - > /dev/null
cd source_code/C++ && ./direct_mapped_cache.out && cd - > /dev/null
cd source_code/C++ && ./direct_mapped_cache_lru.out && cd - > /dev/null

make clean > /dev/null
