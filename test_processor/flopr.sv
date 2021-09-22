module FLOPR #(parameter WIDTH = 32, parameter INITVALUE = 0)
				  (input logic clk, reset, en,
				   input logic [WIDTH-1:0] d,
				  output logic [WIDTH-1:0] q);
				  
always_ff @(posedge clk, posedge reset)
	if (reset) q <= INITVALUE;
	else if (en) q <= q;
	else q <= d;
	
endmodule 
	