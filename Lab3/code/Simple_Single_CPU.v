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
input         clk_i;
input         rst_i;

//Internal Signles

wire [32-1:0] pc_Addri;
wire [32-1:0] pc_Addro;

wire RegWrite;
wire [3:0]ALU_op;

wire [32-1:0]data_SE;

wire [32-1:0]instr;
wire ALUSrc_o;
wire Branch_o;
wire zero_o;
wire MemRead_o;
wire MemWrite_o;
wire MemtoReg_o;
wire Jump_o;
wire isJal;
wire isJr;
wire RegJal_o;
wire [5-1:0] data_M1;
wire [5-1:0] data_M2;
wire [4-1:0] ALUCtrl_o;
wire [32-1:0] RSdata_o;
wire [32-1:0] RTdata_o;
//reg [32-1:0] RDdata_i;
wire [32-1:0] data_ALU;
wire [32-1:0] data_SH;
wire [32-1:0] pc_Addr4;
wire [32-1:0] result_o;
wire [32-1:0] sum_2;
wire [32-1:0] pc_Mux1;
wire [32-1:0] pc_Mux2;
wire [28-1:0] jump_sh;
wire [32-1:0] Memdata_o;
wire [32-1:0] Final_result2;
wire [32-1:0] Final_result1;
assign jump_sh = instr[25:0] << 2;
//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_Addri) ,   
	    .pc_out_o(pc_Addro) 
	    );
	
Adder Adder1(
        .src1_i(pc_Addro),     
	    .src2_i(32'b100),     
	    .sum_o(pc_Addr4)    
	    );
	
Instr_Memory IM(
        .addr_i(pc_Addro),  
	    .instr_o(instr)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr[20:16]),
        .data1_i(instr[15:11]),
        .select_i(RegDst_o),
        .data_o(data_M1)
        );
/*MUX_2to1 #(.size(5)) Mux_isJal(
        .data0_i(data_M1),
        .data1_i(5'b11111),
        .select_i(RegJal_o),
        .data_o(data_M2)
        );*/
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr[25:21]) ,  
        .RTaddr_i(instr[20:16]) ,  
        .RDaddr_i(data_M1) ,  
        .RDdata_i(Final_result2)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)  ,
        .pc_Addro(pc_Addr4),
                .RegJal_o(RegJal_o)

        );
	
Decoder Decoder(
        .instr_op_i(instr[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALU_op),   
	    .ALUSrc_o(ALUSrc_o),   
	    .RegDst_o(RegDst_o),   
		.Branch_o(Branch_o),  
                .MemRead_o(MemRead_o),
                .MemWrite_o(MemWrite_o),
                .MemtoReg_o(MemtoReg_o),
                .Jump_o(Jump_o),
                // .isJal(isJal),
                .funct_i(instr[5:0]),
                // .isJr(isJr),
                .RegJal_o(RegJal_o)
	    );

ALU_Ctrl AC(
        .funct_i(instr[5:0]),   
        .ALUOp_i(ALU_op),   
        .ALUCtrl_o(ALUCtrl_o) ,
        .isJr(isJr)
        );
	
Sign_Extend SE(
        .data_i(instr[15:0]),
        .data_o(data_SE)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RTdata_o),
        .data1_i(data_SE),
        .select_i(ALUSrc_o),
        .data_o(data_ALU)
        );	
		
ALU ALU(
        .src1_i(RSdata_o),
	    .src2_i(data_ALU),
	    .ctrl_i(ALUCtrl_o),
	    .result_o(result_o),
		.zero_o(zero_o),
                .sham(instr[10:6])
	    );
		
Adder Adder2(
        .src1_i(pc_Addr4),     
	    .src2_i(data_SH),     
	    .sum_o(sum_2)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(data_SE),
        .data_o(data_SH)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pc_Addr4),
        .data1_i(sum_2),
        .select_i(Branch_o & zero_o),
        .data_o(pc_Mux1)
        );	
MUX_2to1 #(.size(32)) Mux_Jump(
        .data0_i(pc_Mux1),
        .data1_i({pc_Addro[31:28], jump_sh}),
        .select_i(Jump_o),
        .data_o(pc_Mux2)
        );
MUX_2to1 #(.size(32)) MUX_isJr(
        .data0_i(pc_Mux2),
        .data1_i(RSdata_o),
        .select_i(isJr),
        .data_o(pc_Addri)
        );
Data_Memory Data_Memory(
        .clk_i(clk_i),
        .addr_i(result_o),
        .data_i(RTdata_o),
        .MemRead_i(MemRead_o),
        .MemWrite_i(MemWrite_o),
        .data_o(Memdata_o)

        );

MUX_2to1 #(.size(32)) M1(
        .data0_i(result_o),
        .data1_i(Memdata_o),
        .select_i(MemtoReg_o),
        .data_o(Final_result1)
        );
MUX_2to1 #(.size(32)) M2(
        .data0_i(Final_result1),
        .data1_i(pc_Addr4),
        .select_i(RegJal_o),
        .data_o(Final_result2)
        );

endmodule
		  


