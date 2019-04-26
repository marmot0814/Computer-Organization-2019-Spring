//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
    src2_i,
    ctrl_i,
    result_o,
    zero_o
);
     
//I/O ports
input   [32-1:0]    src1_i;
input   [32-1:0]    src2_i;
input   [4-1:0]     ctrl_i;

output  [32-1:0]    result_o;
output              zero_o;

//Internal signals
reg     [32-1:0]    result_o;
reg                 zero_o;

//Parameter

/*      signal mapping
 ****************************
 *  ctrl_o  ,   operation   *
 ****************************
 *  0000    ,   AND         *
 *  0001    ,   OR          *
 *  0010    ,   ADD         *
 *  0011    ,   beq         *
 *  0100    ,   bne         *
 *  0101    ,   lui         *
 *  0110    ,   sub         *
 *  0111    ,   slt         *
 *  1000    ,   sra         *
 *  1001    ,   srav        *
 ****************************
 */

//Main function
always @(*) begin
    case (ctrl_i)
        4'b0000: result_o <= src1_i & src2_i;       // and
        4'b0001: result_o <= src1_i | src2_i;       // or
        4'b0010: result_o <= src1_i + src2_i;       // add
        4'b0110: result_o <= src1_i - src2_i;       // sub
        4'b0111: result_o <= src1_i < src2_i;       // slt
        4'b0011: result_o <= src1_i != src2_i;      // beq
        4'b0100: result_o <= src1_i == src2_i;      // bnq
        4'b0101: result_o <= src2_i << 16;          // lui
        4'b1000: result_o <= $signed(src2_i) >>> src1_i;      // sra
        4'b1001: result_o <= $signed(src2_i) >>> src1_i;      // srav
        default: result_o <= 0;
    endcase
    zero_o <= (result_o == 0);
end

endmodule
