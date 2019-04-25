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
    ALUCtrl_o
);
          
//I/O ports 
input   [6-1:0]     funct_i;
input   [3-1:0]     ALUOp_i;

output  [4-1:0]     ALUCtrl_o;    
     
//Internal Signals
reg     [4-1:0]     ALUCtrl_o;

//Parameter

       
//Select exact operation
always @(*) begin
    case (ALUOp_i)
        3'b000: begin   // R-type
            case (funct_i)
//                6'b000011: begin    // sra
//                end
//                6'b000111: begin    // srav
//                end
                6'b100001: begin    // addu
                    ALUCtrl_o = 4'b0010;
                end
                6'b100011: begin    // subu
                    ALUCtrl_o = 4'b0110;
                end
                6'b100100: begin    // and
                    ALUCtrl_o = 4'b0000;
                end
                6'b100101: begin    // or
                    ALUCtrl_o = 4'b0001;
                end
                6'b101010: begin    // slt
                    ALUCtrl_o = 4'b0111;
                end
                default: begin
                    ALUCtrl_o = 4'bxxxx;
                end
            endcase
        end
        3'b001: begin   // beq
            ALUCtrl_o = 4'b0110;
        end
        3'b010: begin   // bnq
            ALUCtrl_o = 4'b1110;
        end
        3'b011: begin   // addi
            ALUCtrl_o = 4'b0010;
        end
        3'b100: begin   // lui
            ALUCtrl_o = 4'b0100;
        end
        3'b101: begin   // ori
            ALUCtrl_o = 4'b0001;
        end
        default: begin
            ALUCtrl_o = 4'bxxxx;
        end
    endcase
end

endmodule     





                    
                    
