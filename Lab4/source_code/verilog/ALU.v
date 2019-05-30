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
	zero_o,
	sham
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;
input  [5-1:0] sham;
output [32-1:0]	 result_o;
output           zero_o;

//Internal signals

reg    [32-1:0]  result_o;
wire             zero_o;

//Parameter

//Main function
assign zero_o = (result_o!=0);
always @(*) begin
	case(ctrl_i)
		0:result_o <= src1_i&src2_i;
		1:result_o <= src1_i|src2_i;
		2:result_o <= src1_i+src2_i;
		6:result_o <= src1_i-src2_i;
		7: begin//blt
		if(src1_i[31]==1 && src2_i[31]==0) result_o<=1;
		else if(src2_i[31]==0 && src2_i[31]==1) result_o<=0;
		else begin
			result_o <= (src1_i < src2_i)?1:0;
			end
		end
		8:result_o <= (src1_i==src2_i)?1'b1:1'b0;
		9:result_o <= (src1_i==src2_i)?1'b0:1'b1;

		// 3:result_o <= src2_i << 16;//Load
		3:result_o <= (src1_i!=src2_i)?1'b1:1'b0;//bne
		4:begin	//ble
		if(src1_i[31]==1 && src2_i[31]==0) result_o<=1;
		else if(src2_i[31]==0 && src2_i[31]==1) result_o<=0;
		else begin
			result_o <= (src1_i <= src2_i)?1:0;
			end
		
	
		end
		10:result_o <= $signed(src2_i) >>> sham;//shift immediate
		11:result_o <= $signed(src2_i) >>> src1_i;//shift immediate

		12: result_o <= src1_i * src2_i;
		// 13: result_o <= 1;
		default: result_o<=0;
	endcase
end
endmodule





                    
                    