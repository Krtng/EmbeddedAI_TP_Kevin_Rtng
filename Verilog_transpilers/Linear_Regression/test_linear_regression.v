`timescale 1ns / 1ps
`include "linear_regression.v"

module stimulus;
	// Inputs
	reg [15:0] size;
	// Outputs
	wire [31:0] price;
	wire rout;
	// Instantiate the Unit Under Test (UUT)
	linear_regression uut (
		size, 
		price, 
		rout
	);
 
	initial begin
	$dumpfile("test.vcd");
    $dumpvars(0,stimulus);
		// Initialize Inputs
		size = 16'b0000000000000000;

 
	#20 size = 16'b0000000011011001; // 217

    #200 ;
 
	end  
 
		initial begin
		 $monitor("t=%3d size=%d,price=%d,rout=%d \n",$time,size,price,rout, );
		 end
 
endmodule
 
 
