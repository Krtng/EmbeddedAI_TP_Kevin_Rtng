
`include "multiplier_seize.v"

module linear_regression (price, rout);
    output [31:0] price;
    output rout;
    
    wire [15:0] c0 = 16'b0000000000000000;
    wire [31:0] m0 = {16'b0000000000000000, c0};
    wire rm;

    wire [15:0] c1 = 16'b0000001011001101;
    wire [15:0] x1 = 16'b0000000001100100;
    wire r1;
    wire [31:0] m1;
    wire [15:0] c2 = 16'b1000111111011000;
    wire [15:0] x2 = 16'b0000000000000100;
    wire r2;
    wire [31:0] m2;
    wire [15:0] c3 = 16'b1111110111101000;
    wire [15:0] x3 = 16'b0000000000000001;
    wire r3;
    wire [31:0] m3;

    multiplier_seize mult1 (
        .a (c1), 
        .b (x1), 
        .m (m1), 
        .rout(r1)
    );

    multiplier_seize mult2 (
        .a (c2), 
        .b (x2), 
        .m (m2), 
        .rout(r2)
    );

    multiplier_seize mult3 (
        .a (c3), 
        .b (x3), 
        .m (m3), 
        .rout(r3)
    );

    wire [31:0] add1;
    wire ra1;

    add_seize addLow1 (
        .a (m0[15:0]),
        .b (m1[15:0]),
        .rin (1'b0),
        .s (add1[15:0]),
        .rout (rm)
    );

    add_seize addHigh1 (
        .a (m0[31:16]),
        .b (m1[31:16]),
        .rin (rm),
        .s (add1[31:16]),
        .rout (ra1)
    );
    
        
    wire [31:0] add2;
    wire ra2;
        
    add_seize addLow2 (
        .a (add1[15:0]),
        .b (m2[15:0]),
        .rin (1'b0),
        .s (add2[15:0]),
        .rout (rm)
    );
    
    add_seize addHigh2 (
        .a (add1[31:16]),
        .b (m2[31:16]),
        .rin (rm),
        .s (add2[31:16]),
        .rout (ra2)
    );
    
    add_seize addLow3 (
        .a (add2[15:0]),
        .b (m3[15:0]),
        .rin (1'b0),
        .s (price[15:0]),
        .rout (rm)
    );
    
    add_seize addHigh3 (
        .a (add2[31:16]),
        .b (m3[31:16]),
        .rin (rm),
        .s (price[31:16]),
        .rout (rout)
    );
    
endmodule

