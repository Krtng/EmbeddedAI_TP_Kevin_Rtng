`include "add_huit.v"

module add_seize (a, b, rin, s, rout);
    input [15:0] a;
    input [15:0] b;
    input rin;
    output [15:0] s;
    output rout;

    wire rlow;

    add_huit addLow (
        .a (a[7:0]), 
        .b (b[7:0]), 
        .rin (rin), 
        .s (s[7:0]), 
        .rout (rlow)
    );

    add_huit addHigh (
        .a (a[15:8]), 
        .b (b[15:8]), 
        .rin (rlow), 
        .s (s[15:8]), 
        .rout (rout)
    );


endmodule