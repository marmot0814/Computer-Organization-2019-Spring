`timescale 1ns/1ps

module alu_top(
    src1,       //  1 bit source 1      (input)
    src2,       //  1 bit source 2      (input)
    less,       //  1 bit less          (input)
    equal,      //  1 bit equal         (input)
    A_invert,   //  1 bit A_invert      (input)
    B_invert,   //  1 bit B_invert      (input)
    cin,        //  1 bit carry in      (input)
    operation,  //  4 bits operation    (input)
    comp,       //  3 bits comp         (input)
    result,     //  1 bit result        (output)
    cout,       //  1 bit carry out     (output)
    set         //  1 bit set           (output)
);

input           src1;
input           src2;
input           less;
input           equal;
input           A_invert;
input           B_invert;
input           cin;
input   [2-1:0] operation;
input   [3-1:0] comp;

output          result;
output          cout;
output          set;

reg             result;
reg             set;
reg             cout;
reg	            xor_value;
reg	            a_tmp;
reg	            b_tmp;

wire            comp_result;

generate
    compare cmp(less, equal, comp, comp_result);
endgenerate

always@( * ) begin
	case (A_invert)
		1'b0:	a_tmp =  src1;
		1'b1:	a_tmp = ~src1;
	endcase
	case (B_invert)
		1'b0:	b_tmp =  src2;
		1'b1:	b_tmp = ~src2;
	endcase
	xor_value = (a_tmp ^ b_tmp);
    set = xor_value ^ cin;
	cout   = (a_tmp & b_tmp) | (xor_value & cin);
	case (operation)
		2'b00:  result = a_tmp & b_tmp;
		2'b01:	result = a_tmp | b_tmp;
		2'b10:  result = set;
		2'b11:	result = comp_result;
	endcase
end

endmodule

