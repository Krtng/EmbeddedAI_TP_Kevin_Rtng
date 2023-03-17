`timescale 1ns / 1ps
`include "add_huit.v"

module stimulus;
	// Inputs
	reg [7:0] a;
	reg [7:0] b;
	reg rin;
	// Outputs
	wire [7:0] s;
	wire rout;
	// Instantiate the Unit Under Test (UUT)
	add_huit uut (
		a, 
		b, 
		rin, 
		s, 
		rout
	);
 
	initial begin
	$dumpfile("test.vcd");
    $dumpvars(0,stimulus);
		// Initialize Inputs
		a = 8'b00000000;
		b = 8'b00000000;
		rin = 1'b0;

 
	#10 a = 8'b11011001; // 217
	#10 b = 8'b10010111; // 151, sorties: retenue = 1, s = 0111 0000 = 112 theoriquement

	#10 b = 8'b0010101; // 21, sorties: retenue = 0, s = 1110 111 = 238 theoriquement
    #40 ;
 
	end  
 
		initial begin
		 $monitor("t=%3d a=%d,b=%d,s=%d,rout=%d \n",$time,a,b,s,rout, );
		 end
 
endmodule
 
 
