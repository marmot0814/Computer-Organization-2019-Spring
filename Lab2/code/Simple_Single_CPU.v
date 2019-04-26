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
wire    [32-1:0]    pc_curr_plus4_plusShifted2;

wire    [32-1:0]    instr;

wire                RegWrite;
wire    [3-1:0]     ALU_op;
wire                ALUSrc_1;
wire                ALUSrc_2;
wire                RegDst;
wire                Branch;

wire                ALU_zero;
wire    [32-1:0]    ALU_result;
wire    [32-1:0]    ALU_src1;
wire    [32-1:0]    ALU_src2;

wire    [5-1:0]     RDaddr;
wire    [32-1:0]    RSdata;
wire    [32-1:0]    RTdata;

wire    [32-1:0]    SE_32bit;
wire    [32-1:0]    SE_32bit_shifted;

wire    [4-1:0]     ALUCtrl;
wire                Extend;

wire [32-1:0] shamt;
assign shamt = {27'b0, instr[10:6]};

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
    .select_i(RegDst),
    .data_o(RDaddr)
);
        
Reg_File RF(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .RSaddr_i(instr[25:21]),
    .RTaddr_i(instr[20:16]),
    .RDaddr_i(RDaddr),
    .RDdata_i(ALU_result),
    .RegWrite_i (RegWrite),
    .RSdata_o(RSdata),  
    .RTdata_o(RTdata)
);

Decoder Decoder(
    .instr_op_i(instr[31:26]),
    .RegWrite_o(RegWrite),
    .ALU_op_o(ALU_op),
    .ALUSrc_2_o(ALUSrc_2),
    .RegDst_o(RegDst),
    .Branch_o(Branch)
);

ALU_Ctrl AC(
    .funct_i(instr[5:0]),
    .ALUOp_i(ALU_op),
    .ALUSrc_1_o(ALUSrc_1),
    .ALUCtrl_o(ALUCtrl),
    .Extend_o(Extend)
);
    
Sign_Extend SE(
    .Extend_i(Extend),
    .data_i(instr[16-1:0]),
    .data_o(SE_32bit)
);

MUX_2to1 #(.size(32)) Mux_ALUSrc_1(
    .data0_i(RSdata),
    .data1_i(shamt),
    .select_i(ALUSrc_1),
    .data_o(ALU_src1)
);  

MUX_2to1 #(.size(32)) Mux_ALUSrc_2(
    .data0_i(RTdata),
    .data1_i(SE_32bit),
    .select_i(ALUSrc_2),
    .data_o(ALU_src2)
);  
        
ALU ALU(
    .src1_i(ALU_src1),
    .src2_i(ALU_src2),
    .ctrl_i(ALUCtrl),
    .result_o(ALU_result),
    .zero_o(ALU_zero)
);
        
Adder Adder2(
    .src1_i(pc_curr_plus4),
    .src2_i(SE_32bit_shifted),
    .sum_o(pc_curr_plus4_plusShifted2)
);

Shift_Left_Two_32 Shifter(
    .data_i(SE_32bit),
    .data_o(SE_32bit_shifted)
);      
        
MUX_2to1 #(.size(32)) Mux_PC_Source(
    .data0_i(pc_curr_plus4),
    .data1_i(pc_curr_plus4_plusShifted2),
    .select_i(Branch & ALU_zero),
    .data_o(pc_next)
);  

endmodule
          


