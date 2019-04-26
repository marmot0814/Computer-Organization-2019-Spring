//Subject:     CO project 2 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Sign_Extend(
    Extend_i,
    data_i,
    data_o
);
               
//I/O ports
input               Extend_i;
input   [16-1:0]    data_i;
output  [32-1:0]    data_o;

//Internal Signals
reg     [32-1:0]    data_o;

//Sign extended
always @(*) begin
    data_o[16-1:0]  = data_i;
    data_o[32-1:16] = {16{data_i[15] & Extend_i}};
end
          
endmodule      
     
