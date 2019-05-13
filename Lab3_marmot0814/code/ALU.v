//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616014-0616225
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
 *  0000    ,   and         *
 *  0001    ,   or          *
 *  0010    ,   add         *
 *  0110    ,   sub         *
 *  0111    ,   mul         *
 *  1000    ,   beq         *
 *  1001    ,   bne         *
 *  1010    ,   ble         *
 *  1011    ,   bltz        *
 ****************************
 */

//Main function
always @(*) begin
    case (ctrl_i)
        4'b0000: result_o <= src1_i & src2_i;       // and
        4'b0001: result_o <= src1_i | src2_i;       // or
        4'b0010: result_o <= src1_i + src2_i;       // add
        4'b0110: result_o <= src1_i - src2_i;       // sub
        4'b0111: result_o <= src1_i * src2_i;       // mul
        4'b1000: result_o <= !(src1_i == src2_i);   // beq
        4'b1001: result_o <= !(src1_i != src2_i);   // bnq
        4'b1010: result_o <= !((signed)src1_i <= (signed)src2_i);   // ble
        4'b1011: result_o <= !((signed)src1_i <  (signed)src2_i);   // bltz
        default: result_o <= 32'bx;
    endcase
    zero_o <= (result_o == 0);
end

endmodule
