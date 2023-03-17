`timescale 1ns / 1ps
`include "add.v"

module stimulus;
	// Inputs
	reg a;
	reg b;
	reg rin;
	// Outputs
	wire s;
	wire rout;
	// Instantiate the Unit Under Test (UUT)
	add uut (
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
		a = 0;
		b = 0;
        rin = 0;

 
	#10 a = 1; // 1 + 0 + 0 = 1 (retenue=0)
	#10 b = 1; // 1 + 1 + 0 = 0 (r=1)
	#10 rin = 1; // 1 + 1 + 1 = 1 (r=1)
	#10 a = 0; // 0 + 1 + 1 = 1 (r=0)
 
	end  
 
		initial begin
		 $monitor("t=%3d a=%d,b=%d,rin=%d,s=%d,rout=%d \n",$time,a,b,rin,s,rout, );
		 end
 
endmodule
 
 
