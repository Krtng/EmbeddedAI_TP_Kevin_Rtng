`include "add_huit.v"

module multiplier (a, b, m, rout);
    input [7:0] a;
    input [7:0] b;
    output [15:0] m;
    output rout;

    wire [7:0] m0;
    wire [7:0] m1;
    wire [7:0] m2;
    wire [7:0] m3;
    wire [7:0] m4;
    wire [7:0] m5;
    wire [7:0] m6;
    wire [7:0] m7;
    wire r1, r2, r3, r4, r5, r6;
    wire [7:0] s1; 
    wire [7:0] s2; 
    wire [7:0] s3;
    wire [7:0] s4;
    wire [7:0] s5;
    wire [7:0] s6;
    wire [7:0] s7;

    assign m0[7:0] = {8{a[0]}} & b;
    assign m1[7:0] = {8{a[1]}} & b;
    assign m2[7:0] = {8{a[2]}} & b;
    assign m3[7:0] = {8{a[3]}} & b;
    assign m4[7:0] = {8{a[4]}} & b;
    assign m5[7:0] = {8{a[5]}} & b;
    assign m6[7:0] = {8{a[6]}} & b;
    assign m7[7:0] = {8{a[7]}} & b;
    
    assign m[0] = m0[0];

    add_huit s_1 (
        .a ({1'b0, m0[7:1]}),
        .b (m1),
        .rin (1'b0),
        .s (s1),
        .rout (r1)
    );

    assign m[1] = s1[0];

    add_huit s_2 (
        .a ({r1, s1[7:1]}),
        .b (m2),
        .rin (1'b0),
        .s (s2),
        .rout (r2)
    );

    assign m[2] = s2[0];

    add_huit s_3 (
        .a ({r2, s2[7:1]}),
        .b (m3),
        .rin (1'b0),
        .s (s3),
        .rout (r3)
    );

    assign m[3] = s3[0];

    add_huit s_4 (
        .a ({r3, s3[7:1]}),
        .b (m4),
        .rin (1'b0),
        .s (s4),
        .rout (r4)
    );

    assign m[4] = s4[0];

    add_huit s_5 (
        .a ({r4, s4[7:1]}),
        .b (m5),
        .rin (1'b0),
        .s (s5),
        .rout (r5)
    );

    assign m[5] = s5[0];

    add_huit s_6 (
        .a ({r5, s5[7:1]}),
        .b (m6),
        .rin (1'b0),
        .s (s6),
        .rout (r6)
    );

    assign m[6] = s6[0];

    add_huit s_7 (
        .a ({r6, s6[7:1]}),
        .b (m7),
        .rin (1'b0),
        .s (s7),
        .rout (rout)
    );

    assign m[14:7] = s7;
    assign m[15] = rout;

endmodule
