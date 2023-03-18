`include "multiplier_seize.v"

module linear_regression (size, price, rout);
    input [15:0] size;
    output [31:0] price;
    output [31:0] multi;
    output rout;

    wire [15:0] coef = 16'b0010011100010000;
    wire rm;

    multiplier_seize mult (
        .a (coef), 
        .b (size), 
        .m (multi), 
        .rout(rout)
    );

    // 32 bits adder through two 16 bits adders
    add_seize pLow (
        .a (multi[15:0]),
        .b (coef),
        .rin (1'b0),
        .s (price[15:0]),
        .rout (rm)
    );

    add_seize pHigh (
        .a (multi[31:16]),
        .b (16'b0000000000000000),
        .rin (rm),
        .s (price[31:16]),
        .rout (rout)
    );

endmodule
