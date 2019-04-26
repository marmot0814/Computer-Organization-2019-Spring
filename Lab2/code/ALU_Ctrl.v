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
    ALUSrc_1_o,
    ALUCtrl_o,
    Extend_o
);
          
//I/O ports 
input   [6-1:0]     funct_i;
input   [3-1:0]     ALUOp_i;

output              ALUSrc_1_o;
output  [4-1:0]     ALUCtrl_o;
output              Extend_o;

//Internal Signals
reg                 ALUSrc_1_o;
reg     [4-1:0]     ALUCtrl_o;
reg                 Extend_o;

//Parameter
/*      signal mapping
 ****************************
 *  ALUCtrl ,   operation   *
 ****************************
 *  0000    ,   and         *
 *  0001    ,   or          *
 *  0010    ,   add         *
 *  0011    ,   beq         *
 *  0100    ,   bne         *
 *  0101    ,   lui         *
 *  0110    ,   sub         *
 *  0111    ,   slt         *
 ****************************

 * candidate:   beq, bne, lui
 ****************************
 *  ALUOp   ,   operation   *
 ****************************
 *  000     ,   R-Type      *
 *  001     ,   ori         *
 *  010     ,   addi        *
 *  011     ,   beq         *
 *  100     ,   bne         *
 *  101     ,   lui         *
 *  110     ,   N/A         *
 *  111     ,   slti        *
 ****************************
 */

       
//Select exact operation
always @(*) begin
    case (ALUOp_i)
        3'b000: begin
            case (funct_i)
                6'b100100:  begin                   // and
                    ALUSrc_1_o  = 1'b0;
                    ALUCtrl_o   = 4'b0000;
                    Extend_o    = 1'bx;
                end
                6'b100101:  begin                   // or
                    ALUSrc_1_o  = 1'b0;
                    ALUCtrl_o   = 4'b0001;
                    Extend_o    = 1'bx;
                end
                6'b100001:  begin                   // addu
                    ALUSrc_1_o  = 1'b0;
                    ALUCtrl_o   = 4'b0010;
                    Extend_o    = 1'bx;
                end
                6'b100011:  begin                   // subu
                    ALUSrc_1_o  = 1'b0;
                    ALUCtrl_o   = 4'b0110;
                    Extend_o    = 1'bx;
                end
                6'b101010:  begin                   // slt
                    ALUSrc_1_o  = 1'b0;
                    ALUCtrl_o   = 4'b0111;
                    Extend_o    = 1'bx;
                end
                6'b000011: begin                    // sra
                    ALUSrc_1_o  = 1'b1;
                    ALUCtrl_o   = 4'b1000;
                    Extend_o    = 1'bx;
                end
                6'b000111: begin                    // srav
                    ALUSrc_1_o  = 1'b0;
                    ALUCtrl_o   = 4'b1001;
                    Extend_o    = 1'bx;
                end
            endcase
        end
        3'b001: begin                               // ori
            ALUSrc_1_o  = 1'b0;
            ALUCtrl_o   = {1'b0, ALUOp_i};
            Extend_o    = 1'b1;
        end
        3'b010: begin                               // addi
            ALUSrc_1_o  = 1'b0;
            ALUCtrl_o   = {1'b0, ALUOp_i};
            Extend_o    = 1'b1;
        end
        3'b111: begin                               // sltiu
            ALUSrc_1_o  = 1'b0;
            ALUCtrl_o   = {1'b0, ALUOp_i};
            Extend_o    = 1'b0;
        end
        3'b011: begin                               // beq
            ALUSrc_1_o  = 1'b0;
            ALUCtrl_o   = {1'b0, ALUOp_i};
            Extend_o    = 1'b1;
        end
        3'b100: begin                               // bne
            ALUSrc_1_o  = 1'b0;
            ALUCtrl_o   = {1'b0, ALUOp_i};
            Extend_o    = 1'b1;
        end
        3'b101: begin                               // lui
            ALUSrc_1_o  = 1'b0;
            ALUCtrl_o   = {1'b0, ALUOp_i};
            Extend_o    = 1'b1;
        end
    endcase
end

endmodule
