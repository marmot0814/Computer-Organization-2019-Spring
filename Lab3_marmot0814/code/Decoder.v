//Subject:     CO project 3 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616014-0616225
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
    RegWrite_o,
    ALU_op_o,
    ALUSrc_2_o,
    RegDst_o,
    Branch_o
);
     
//I/O ports
input   [6-1:0] instr_op_i;

output          RegWrite_o;
output  [3-1:0] ALU_op_o;
output          ALUSrc_2_o;
output          RegDst_o;
output          Branch_o;
 
//Internal Signals
reg     [3-1:0] ALU_op_o;
reg             ALUSrc_2_o;
reg             RegWrite_o;
reg             RegDst_o;
reg             Branch_o;

//Parameter


//Main function
always @(*) begin

end
endmodule
