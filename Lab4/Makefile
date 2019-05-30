all:
	cd source_code/verilog && iverilog TestBench.v CPU.v Adder.v ALU.v Decoder.v ProgramCounter.v Shift_Left_Two_32.v ALU_Ctrl.v Data_Memory.v Instruction_Memory.v MUX_2to1.v Reg_File.v Sign_Extend.v && cd -
	cd source_code/C++ && g++ direct_mapped_cache.cpp && cd -


