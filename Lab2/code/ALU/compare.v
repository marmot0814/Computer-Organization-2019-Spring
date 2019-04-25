`timescale 1ns/1ps

module compare(
    less,       //  1 bit less      (input)
    equal,      //  1 bit equal     (input)
    comp,       //  3 bits comp     (input)
    result      //  1 bit result    (output)
);

input           less;
input           equal;
input   [3-1:0] comp;

output          result;

reg             result;
reg             or_value;

always@( * ) begin
    or_value = less | equal;
    case (comp)
        3'b000: result = less;
        3'b001: result = ~or_value;
        3'b010: result = or_value;
        3'b011: result = ~less;
        3'b110: result = equal;
        3'b100: result = ~equal;
    endcase
end

endmodule

