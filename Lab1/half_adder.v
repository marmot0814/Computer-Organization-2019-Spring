`timescale 1ns/1ps

module half_adder(
    src1,       //  1 bit source 1  (input)
    src2,       //  1 bit source 2  (input)
    sum,        //  1 bit sum       (output)
    cout        //  1 bit carry out (output)
);

input   src1;
input   src2;

output  sum;
output  cout;

reg     sum;
reg     cout;

always@( * ) begin
    sum  = src1 ^ src2;
    cout = src1 & src2;
end

endmodule

