//Subject:     CO project 3 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616014-0616225
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
    funct_i,
    ALUOp_i,
    ALUSrc_1_o,
    ALUCtrl_o,
);
          
//I/O ports 
input   [6-1:0]     funct_i;
input   [3-1:0]     ALUOp_i;

output              ALUSrc_1_o;
output  [4-1:0]     ALUCtrl_o;

//Internal Signals
reg                 ALUSrc_1_o;
reg     [4-1:0]     ALUCtrl_o;

//Parameter
/*      signal mapping
 ****************************
 *  ALUCtrl ,   operation   *
 ****************************
 *          ,               *
 ****************************

 * candidate:   beq, bne, lui
 ****************************
 *  ALUOp   ,   operation   *
 ****************************
 *          ,               *
 ****************************
 */

       
//Select exact operation
always @(*) begin

end
endmodule
