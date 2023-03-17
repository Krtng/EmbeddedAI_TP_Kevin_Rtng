`include "add.v"

module add_huit (a, b, rin, s, rout);
    input [7:0] a;
    input [7:0] b;
    input rin;
    output [7:0] s;
    output rout;

    wire r0, r1, r2, r3, r4, r5, r6;

    add s0 (
        .a (a[0]),
        .b (b[0]),
        .rin (rin),
        .s (s[0]),
        .rout (r0)
    );

    add s1 (
        .a (a[1]),
        .b (b[1]),
        .rin (r0),
        .s (s[1]),
        .rout (r1)
    );

    add s2 (
        .a (a[2]),
        .b (b[2]),
        .rin (r1),
        .s (s[2]),
        .rout (r2)
    );

    add s3 (
        .a (a[3]),
        .b (b[3]),
        .rin (r2),
        .s (s[3]),
        .rout (r3)
    );

    add s4 (
        .a (a[4]),
        .b (b[4]),
        .rin (r3),
        .s (s[4]),
        .rout (r4)
    );

    add s5 (
        .a (a[5]),
        .b (b[5]),
        .rin (r4),
        .s (s[5]),
        .rout (r5)
    );

    add s6 (
        .a (a[6]),
        .b (b[6]),
        .rin (r5),
        .s (s[6]),
        .rout (r6)
    );

    add s7 (
        .a (a[7]),
        .b (b[7]),
        .rin (r6),
        .s (s[7]),
        .rout (rout)
    );

endmodule
