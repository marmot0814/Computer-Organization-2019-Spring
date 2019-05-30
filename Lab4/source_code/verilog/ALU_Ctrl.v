//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o,
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
//Internal Signals
reg        [4-1:0] ALUCtrl_o;
//Parameter

       
//Select exact operation
always@(*) begin
	 // isJr = (funct_i==6'b001_000 && ALUOp_i==4'b010)?1'b1:1'b0;
	case(ALUOp_i) 
		4'b010: begin
			case(funct_i)
				6'b100_001: ALUCtrl_o <= 2;
				6'b100_011: ALUCtrl_o <= 6;
				6'b100_100: ALUCtrl_o <= 0;
				6'b100_101: ALUCtrl_o <= 1;
				6'b101_010: ALUCtrl_o <= 7;//slr
				6'b000_011: ALUCtrl_o <= 10;//sh immediate
				6'b000_111: ALUCtrl_o <= 11;//shv
				6'b011_000: ALUCtrl_o <= 12;//mul
				// 6'b001_000: ALUCtrl_o <= 13;//jr
			endcase
			end
		//Add immediate
		4'b011: ALUCtrl_o <= 2;//Addi

		//Slt immediate
		// 3'b011: ALUCtrl_o <= 7;//slt
		//lw, li
		4'b000: ALUCtrl_o <= 2;
		//sw
		4'b001: ALUCtrl_o <= 2;

		//or immediate
		4'b101: ALUCtrl_o <= 1;
		//bne
		4'b110: ALUCtrl_o <= 3;
		//ble
		4'b1000: ALUCtrl_o <= 4;
		//bnez
		4'b0111: ALUCtrl_o <= 3;
		//bltz
		4'b1001: ALUCtrl_o <= 7;
		//beq
		4'b1010: ALUCtrl_o <= 8;

	endcase

end
endmodule     





                    
                    