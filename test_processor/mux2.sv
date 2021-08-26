module MUX2 #(parameter WIDTH = 32)
				 (input logic [WIDTH-1:0] a, b,
				  input logic cond,
				 output logic [WIDTH-1:0] c);
				 
assign c = cond ? b : a;

endmodule 