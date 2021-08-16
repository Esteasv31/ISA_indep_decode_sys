module FLOPENCLR #(parameter WIDTH = 32)
						(input logic clk, reset, clr, en,
						 input logic [WIDTH-1:0] d,
						output logic [WIDTH-1:0] q);
						
always_ff @(posedge clk, posedge clr, posedge reset)
	if (reset) q <= 0;
	else if (clr) q <= 0;
	else if (en) q <= q;
	else q <= d;
	
endmodule 