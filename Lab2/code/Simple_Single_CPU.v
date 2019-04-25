//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
    clk_i,
    rst_i
);
        
//I/O port
input   clk_i;
input   rst_i;

//Internal Signles

wire    [32-1:0]    pc_next;
wire    [32-1:0]    pc_curr;
wire    [32-1:0]    pc_curr_plus4;

wire    [32-1:0]    instr;

//Greate componentes
ProgramCounter PC(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .pc_in_i(pc_next),
    .pc_out_o(pc_curr)
);
    
Adder Adder1(
    .src1_i(pc_curr),
    .src2_i(32'd4),
    .sum_o(pc_curr_plus4)
);

Instr_Memory IM(
    .pc_addr_i(pc_curr),
    .instr_o(instr)
);

MUX_2to1 #(.size(5)) Mux_Write_Reg(
    .data0_i(instr[20:16]),
    .data1_i(instr[15:11]),
    .select_i(),
    .data_o()
);
        
Reg_File RF(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .RSaddr_i(instr[25:21]),
    .RTaddr_i(instr[20:16]),
    .RDaddr_i(),
    .RDdata_i()  , 
    .RegWrite_i (),
    .RSdata_o() ,  
    .RTdata_o()   
);
    
Decoder Decoder(
    .instr_op_i(instr[31:26]),
    .RegWrite_o(),
    .ALU_op_o(),
    .ALUSrc_o(),
    .RegDst_o(),
    .Branch_o() 
);

ALU_Ctrl AC(
    .funct_i(instr[5:0]),
    .ALUOp_i(),
    .ALUCtrl_o()
);
    
Sign_Extend SE(
    .data_i(instr[16-1:0]),
    .data_o()
);

MUX_2to1 #(.size(32)) Mux_ALUSrc(
    .data0_i(),
    .data1_i(),
    .select_i(),
    .data_o()
);  
        
ALU ALU(
    .rst_i(rst_i),
    .src1_i(),
    .src2_i(),
    .ctrl_i(),
    .result_o(),
    .zero_o()
);
        
Adder Adder2(
    .src1_i(),
    .src2_i(),
    .sum_o()
);

Shift_Left_Two_32 Shifter(
    .data_i(),
    .data_o()
);      
        
MUX_2to1 #(.size(32)) Mux_PC_Source(
    .data0_i(),
    .data1_i(),
    .select_i(),
    .data_o()
);  

endmodule
          


