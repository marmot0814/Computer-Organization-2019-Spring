all:
	cd source_code/verilog && iverilog TestBench.v CPU.v Adder.v ALU.v Decoder.v ProgramCounter.v Shift_Left_Two_32.v ALU_Ctrl.v Data_Memory.v Instruction_Memory.v MUX_2to1.v Reg_File.v Sign_Extend.v && cd -
	cd source_code/C++ && g++ -o direct_mapped_cache.out direct_mapped_cache.cpp && cd -
	cd source_code/C++ && g++ -o direct_mapped_cache_lru.out direct_mapped_cache_lru.cpp && cd -

clean:
	cd source_code/verilog && rm a.out && cd -
	cd source_code/C++ && rm direct_mapped_cache.out && cd -
	cd source_code/C++ && rm direct_mapped_cache_lru.out && cd -


