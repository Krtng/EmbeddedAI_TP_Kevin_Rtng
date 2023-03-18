`include "add_seize.v"

module multiplier_seize (a, b, m, rout);
    input [15:0] a;
    input [15:0] b;
    output [31:0] m;
    output rout;

    wire [15:0] m0;
    wire [15:0] m1;
    wire [15:0] m2;
    wire [15:0] m3;
    wire [15:0] m4;
    wire [15:0] m5;
    wire [15:0] m6;
    wire [15:0] m7;
    wire [15:0] m8;
    wire [15:0] m9;
    wire [15:0] m10;
    wire [15:0] m11;
    wire [15:0] m12;
    wire [15:0] m13;
    wire [15:0] m14;
    wire [15:0] m15;
    wire r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14;
    wire [15:0] s1; 
    wire [15:0] s2; 
    wire [15:0] s3;
    wire [15:0] s4;
    wire [15:0] s5;
    wire [15:0] s6;
    wire [15:0] s7;
    wire [15:0] s8;
    wire [15:0] s9;
    wire [15:0] s10;
    wire [15:0] s11;
    wire [15:0] s12;
    wire [15:0] s13;
    wire [15:0] s14;
    wire [15:0] s15;

    assign m0[15:0] = {16{a[0]}} & b;
    assign m1[15:0] = {16{a[1]}} & b;
    assign m2[15:0] = {16{a[2]}} & b;
    assign m3[15:0] = {16{a[3]}} & b;
    assign m4[15:0] = {16{a[4]}} & b;
    assign m5[15:0] = {16{a[5]}} & b;
    assign m6[15:0] = {16{a[6]}} & b;
    assign m7[15:0] = {16{a[7]}} & b;
    assign m8[15:0] = {16{a[8]}} & b;
    assign m9[15:0] = {16{a[9]}} & b;
    assign m10[15:0] = {16{a[10]}} & b;
    assign m11[15:0] = {16{a[11]}} & b;
    assign m12[15:0] = {16{a[12]}} & b;
    assign m13[15:0] = {16{a[13]}} & b;
    assign m14[15:0] = {16{a[14]}} & b;
    assign m15[15:0] = {16{a[15]}} & b;
    
    assign m[0] = m0[0];

    add_seize s_1 (
        .a ({1'b0, m0[15:1]}),
        .b (m1),
        .rin (1'b0),
        .s (s1),
        .rout (r1)
    );

    assign m[1] = s1[0];

    add_seize s_2 (
        .a ({r1, s1[15:1]}),
        .b (m2),
        .rin (1'b0),
        .s (s2),
        .rout (r2)
    );

    assign m[2] = s2[0];

    add_seize s_3 (
        .a ({r2, s2[15:1]}),
        .b (m3),
        .rin (1'b0),
        .s (s3),
        .rout (r3)
    );

    assign m[3] = s3[0];

    add_seize s_4 (
        .a ({r3, s3[15:1]}),
        .b (m4),
        .rin (1'b0),
        .s (s4),
        .rout (r4)
    );

    assign m[4] = s4[0];

    add_seize s_5 (
        .a ({r4, s4[15:1]}),
        .b (m5),
        .rin (1'b0),
        .s (s5),
        .rout (r5)
    );

    assign m[5] = s5[0];

    add_seize s_6 (
        .a ({r5, s5[15:1]}),
        .b (m6),
        .rin (1'b0),
        .s (s6),
        .rout (r6)
    );

    assign m[6] = s6[0];

    add_seize s_7 (
        .a ({r6, s6[15:1]}),
        .b (m7),
        .rin (1'b0),
        .s (s7),
        .rout (r7)
    );

    assign m[7] = s7[0];

    add_seize s_8 (
        .a ({r7, s7[15:1]}),
        .b (m8),
        .rin (1'b0),
        .s (s8),
        .rout (r8)
    );

    assign m[8] = s8[0];

    add_seize s_9 (
        .a ({r8, s8[15:1]}),
        .b (m9),
        .rin (1'b0),
        .s (s9),
        .rout (r9)
    );

    assign m[9] = s9[0];

    add_seize s_10 (
        .a ({r9, s9[15:1]}),
        .b (m10),
        .rin (1'b0),
        .s (s10),
        .rout (r10)
    );

    assign m[10] = s10[0];

    add_seize s_11 (
        .a ({r10, s10[15:1]}),
        .b (m11),
        .rin (1'b0),
        .s (s11),
        .rout (r11)
    );

    assign m[11] = s11[0];

    add_seize s_12 (
        .a ({r11, s11[15:1]}),
        .b (m12),
        .rin (1'b0),
        .s (s12),
        .rout (r12)
    );

    assign m[12] = s12[0];

    add_seize s_13 (
        .a ({r12, s12[15:1]}),
        .b (m13),
        .rin (1'b0),
        .s (s13),
        .rout (r13)
    );

    assign m[13] = s13[0];

    add_seize s_14 (
        .a ({r13, s13[15:1]}),
        .b (m14),
        .rin (1'b0),
        .s (s14),
        .rout (r14)
    );

    assign m[14] = s14[0];

    add_seize s_15 (
        .a ({r14, s14[15:1]}),
        .b (m15),
        .rin (1'b0),
        .s (s15),
        .rout (rout)
    );
    
    assign m[30:15] = s15;
    assign m[31] = rout;

endmodule
