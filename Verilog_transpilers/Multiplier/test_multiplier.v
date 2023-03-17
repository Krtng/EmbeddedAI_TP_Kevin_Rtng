`timescale 1ns / 1ps
`include "multiplier.v"

module stimulus;
	// Inputs
	reg [7:0] a;
	reg [7:0] b;
	// Outputs
	wire [15:0] m;
	wire rout;
	// Instantiate the Unit Under Test (UUT)
	multiplier uut (
		a, 
		b, 
		m, 
		rout
	);
 
	initial begin
	$dumpfile("test.vcd");
    $dumpvars(0,stimulus);
		// Initialize Inputs
		a = 8'b00000000;
		b = 8'b00000000;

 
	#20 a = 8'b11011001; // 217
	#20 b = 8'b10010111; // 151, sorties: retenue = 0, m= 32 767 = 7FFF theoriquement

	#40 b = 8'b0010101; // 21, sorties: retenue = 0, m = 4557 = 11CD theoriquement
	#20 a = 8'b0000010; // 2, sorties: ret = 0, m = 42 = 2A
	#20 b = 8'b0000010; // 2, sorties: ret = 0, m = 4 = 4
	#20 b = 8'b0000100; // 4, sorties: ret = 0, m = 8 = 8
    #200 ;
 
	end  
 
		initial begin
		 $monitor("t=%3d a=%d,b=%d,m=%d,rout=%d \n",$time,a,b,m,rout, );
		 end
 
endmodule
 
 
