import joblib
import numpy as np

# Load the trained linear regression model through the joblib file.
model = joblib.load('regression.joblib')


def get_coef(_model):
    return [coef for coef in _model.coef_]


# Get the coefficients of the model
intercept = int(model.intercept_)
if intercept > 65000:
    intercept = 65000
if intercept < 0:
    intercept = 0


coeffs = get_coef(model)
for i in range(len(coeffs)):
    coeffs[i] = int(coeffs[i])
    if coeffs[i] > 65000:
        coeffs[i] = 65000
    coeffs[i] = "16'b" + format(coeffs[i], "016b")

x_input = [100, 4, 1]
x_size = len(x_input)
x_bin = [0 for j in range(len(x_input))]
for k in range(len(x_input)):
    x_input[k] = int(x_input[k])
    if x_input[k] > 65000:
        x_input[k] = 65000
    x_bin[k] = "16'b" + format(x_input[k], "016b")

# String that contains the Verilog code that computes the prediction of the model

code_pred = f"""
`include "multiplier_seize.v"

module linear_regression (price, rout);
    output [31:0] price;
    output rout;
    
    wire [15:0] c0 = {"16'b" + format(intercept, "016b")};
    wire [31:0] m0 = {{16'b0000000000000000, c0}};
    wire rm;
"""

for l in range(len(coeffs)):
    code_pred += f"""
    wire [15:0] c{str(l+1)} = {coeffs[l]};
    wire [15:0] x{str(l+1)} = {x_bin[l]};
    wire r{str(l+1)};
    wire [31:0] m{str(l+1)};"""

for m in range(len(coeffs)):
    code_pred += f"""

    multiplier_seize mult{str(m+1)} (
        .a (c{str(m+1)}), 
        .b (x{str(m+1)}), 
        .m (m{str(m+1)}), 
        .rout(r{str(m+1)})
    );"""

for n in range(len(coeffs)):
    if n == len(coeffs) - 1:
        code_pred += f"""
    add_seize addLow{str(n+1)} (
        .a (add{str(n)}[15:0]),
        .b (m{str(n+1)}[15:0]),
        .rin (1'b0),
        .s (price[15:0]),
        .rout (rm)
    );
    
    add_seize addHigh{str(n+1)} (
        .a (add{str(n)}[31:16]),
        .b (m{str(n+1)}[31:16]),
        .rin (rm),
        .s (price[31:16]),
        .rout (rout)
    );
    """
    elif n == 0:
        code_pred += f"""

    wire [31:0] add{str(n + 1)};
    wire ra{str(n + 1)};

    add_seize addLow{str(n + 1)} (
        .a (m0[15:0]),
        .b (m1[15:0]),
        .rin (1'b0),
        .s (add1[15:0]),
        .rout (rm)
    );

    add_seize addHigh{str(n + 1)} (
        .a (m0[31:16]),
        .b (m1[31:16]),
        .rin (rm),
        .s (add1[31:16]),
        .rout (ra1)
    );
    """
    else:
        code_pred += f"""
        
    wire [31:0] add{str(n+1)};
    wire ra{str(n+1)};
        
    add_seize addLow{str(n+1)} (
        .a (add{str(n)}[15:0]),
        .b (m{str(n+1)}[15:0]),
        .rin (1'b0),
        .s (add{str(n+1)}[15:0]),
        .rout (rm)
    );
    
    add_seize addHigh{str(n+1)} (
        .a (add{str(n)}[31:16]),
        .b (m{str(n+1)}[31:16]),
        .rin (rm),
        .s (add{str(n+1)}[31:16]),
        .rout (ra{str(n+1)})
    );
    """
code_pred += f"""
endmodule

"""

code_file = open('linear_regression.v', 'w')
code_file.write(code_pred)
code_file.close()

code_testbench = f"""
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
		 $monitor("t=%3d price=%d,rout=%d \\n",$time,price,rout, );
		 end
 
endmodule

"""

testbench_file = open('test_linear_regression.v', 'w')
testbench_file.write(code_testbench)
testbench_file.close()

y_pred = model.predict(np.array(x_input).reshape(1, -1))
print("\nPredicted house price in Python : " + str(y_pred))
