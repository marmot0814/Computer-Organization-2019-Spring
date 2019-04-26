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
    rst_i,
    src1_i,
    src2_i,
    ctrl_i,
    result_o,
    zero_o
);
     
//I/O ports
input               rst_i;
input   [32-1:0]    src1_i;
input   [32-1:0]    src2_i;
input   [4-1:0]     ctrl_i;

output  [32-1:0]    result_o;
output              zero_o;

//Internal signals
wire    [32-1:0]    result_o;
wire                zero_o;

//Parameter
alu alu(
    .rst_n(rst_i),
    .src1(src1_i),
    .src2(src2_i),
    .ALU_control(ctrl_i),
    .bonus_control(3'b000),
    .result(result_o),
    .zero(zero_o),
    .cout(),
    .overflow()
);

//Main function

endmodule





                    
                    
