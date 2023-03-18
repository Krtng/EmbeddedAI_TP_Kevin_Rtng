
`timescale 1ns / 1ps
`include "linear_regression.v"

module stimulus;
	// Outputs
	wire [31:0] price;
	wire rout;
	// Instantiate the Unit Under Test (UUT)
	linear_regression uut (
		price, 
		rout
	);
 
	initial begin
	$dumpfile("test.vcd");
    $dumpvars(0,stimulus);

    #50;
 
	end  
 
		initial begin
		 $monitor("t=%3d price=%d,rout=%d \n",$time,price,rout, );
		 end
 
endmodule

