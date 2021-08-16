module ADD_CARRY #(parameter WIDTH = 32)
						(input logic [WIDTH-1:0] a, b,
						 input logic cIn,
						output logic [WIDTH-1:0] c,
						output logic cOut);
						
assign {cOut, c} = a + b + cIn;

endmodule 