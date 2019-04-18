`timescale 1ns/1ps

module full_adder(
    src1,       //  1 bit source 1  (input)
    src2,       //  1 bit source 2  (input)
    cin,        //  1 bit carry in  (input)
    sum,        //  1 bit sum       (output)
    cout        //  1 bit carry out (output)
);

input   src1;
input   src2;
input   cin;

output  sum;
output  cout;

reg     sum;
reg     cout;

wire    [2-1:0] half_adder_carry;
wire    [2-1:0] half_adder_sum;

generate
    half_adder ha0(src1, src2, half_adder_sum[0], half_adder_carry[0]);
    half_adder ha1(cin, half_adder_sum[0], half_adder_sum[1], half_adder_carry[1]);
endgenerate

always@( * ) begin
    sum  = half_adder_sum[1];
    cout = half_adder_carry[0] | half_adder_carry[1];
end

endmodule
