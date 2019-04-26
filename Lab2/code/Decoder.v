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
    case (instr_op_i)
        6'b000000: begin    // R-Type
            RegWrite_o  = 1'b1;
            ALU_op_o    = 3'b000;
            ALUSrc_2_o  = 1'b0;
            RegDst_o    = 1'b1;
            Branch_o    = 1'b0;
        end
        6'b001000: begin    // addi
            RegWrite_o  = 1'b1;
            ALU_op_o    = 3'b010;
            ALUSrc_2_o  = 1'b1;
            RegDst_o    = 1'b0;
            Branch_o    = 1'b0;
        end
        6'b001011: begin    // sltiu
            RegWrite_o  = 1'b1;
            ALU_op_o    = 3'b111;
            ALUSrc_2_o  = 1'b1;
            RegDst_o    = 1'b0;
            Branch_o    = 1'b0;
        end
        6'b000100: begin    // beq
           RegWrite_o   = 1'b0;
           ALU_op_o     = 3'b011;
           ALUSrc_2_o   = 1'b0;
           RegDst_o     = 1'bx;
           Branch_o     = 1'b1;
        end
        6'b000101: begin     // bne
            RegWrite_o  = 1'b0;
            ALU_op_o    = 3'b100;
            ALUSrc_2_o  = 1'b0;
            RegDst_o    = 1'bx;
            Branch_o    = 1'b1;
        end
        6'b001111: begin     // lui
            RegWrite_o  = 1'b1;
            ALU_op_o    = 3'b101;
            ALUSrc_2_o  = 1'b1;
            RegDst_o    = 1'b0;
            Branch_o    = 1'b0;
        end
        6'b001101: begin    // ori
            RegWrite_o  = 1'b1;
            ALU_op_o    = 3'b001;
            ALUSrc_2_o  = 1'b1;
            RegDst_o    = 1'b0;
            Branch_o    = 1'b0;
        end
    endcase
end

endmodule
