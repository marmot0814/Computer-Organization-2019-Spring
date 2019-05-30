//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o,
	Jump_o,
	// isJal,
	funct_i,
	isJr,
	RegJal_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;
input [5:0] funct_i;
output         RegWrite_o;
output [3:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output 		MemWrite_o;
output 		MemRead_o;
output 		MemtoReg_o;
output 		Jump_o;
// output 		isJal;
output 		isJr;
output 		RegJal_o;
//Internal Signals
reg    [3:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg 		MemWrite_o;
reg 		MemRead_o;
reg 		MemtoReg_o;
reg 		Jump_o;
// reg 		isJal;
reg 		isJr;
reg 		RegJal_o;
//Parameter


//Main function
always@(*) begin
	ALUSrc_o = (instr_op_i[3]==1'b1 || instr_op_i==6'b100011 )/*lw, li,sw, immediate*/
	?1'b1:(instr_op_i[2]==1 || instr_op_i==6'b0 || instr_op_i==6'b1)?1'b0:1'bx/*j, jal, jr*/;

	RegWrite_o = (instr_op_i==6'b0 && funct_i==6'b1000)?/*jr*/1'b0:(instr_op_i==6'b0)?1'b1:
	(instr_op_i==6'b001000 || instr_op_i==6'b100011 || instr_op_i==6'b001111 || instr_op_i==6'b000011)/*addi, lw, li, jal*/?1'b1:1'b0;
	
	Branch_o = (instr_op_i==6'b000100 || instr_op_i == 6'b000101 || instr_op_i == 6'b000001 || instr_op_i==6'b000110)
	?1'b1:1'b0 ;

	MemtoReg_o = (instr_op_i == 6'b100011)/* lw*/?1'b1:1'b0;
	isJr = (instr_op_i==6'b0 && funct_i==6'b1000)?/*jr*/1'b1:1'b0;
	MemWrite_o = (instr_op_i==6'b101011)?1'b1:1'b0;
	MemRead_o = (instr_op_i==6'b100011 )?1'b1:1'b0;
	Jump_o = (instr_op_i==6'b000010 || instr_op_i==6'b000011 || (instr_op_i==6'b000000 && funct_i==6'b001000) )/*j and jal*/?1'b1:1'b0;
	// isJal = (instr_op_i==6'b000011)?1'b1:1'b0;
	// isJr = (instr_op_i==6'b0)?1'b0:1'b0;
	RegJal_o = (instr_op_i==6'b000_011)/*jal*/?1'b1:1'b0;
	RegDst_o = (instr_op_i==6'b0)?1'b1:(instr_op_i==6'b001000 || instr_op_i==6'b100011 || instr_op_i==6'b001111)
	?1'b0:1'bx;

	ALU_op_o = (instr_op_i==6'b0)?4'b010/*Rtype*/:(instr_op_i==6'b100011 || instr_op_i==6'b001111)?4'b000/*lw, li*/:
	(instr_op_i==6'b101011)?4'b001/*sw*/:	(instr_op_i[3]==1'b1)?4'b011:/*Itype_add*/
	(instr_op_i==6'b000110)?4'b1000/*ble*/: (instr_op_i==6'b000101)?4'b111/*bnez*/:
	(instr_op_i==6'b1)?4'b1001/*bltz*/:(instr_op_i==6'b000100)?4'b1010/*beq*/:1'bx;
end
endmodule





                    
                    