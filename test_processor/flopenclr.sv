/* 
 * custom FLIP-FLOP 
 * holds a clear (clr) signal to clear the register value
 * if en (1) it holds the prev value / if en (0) the value change on the positive edge of the clk
 */
module FLOPENCLR #(parameter WIDTH = 32)
						(input logic clk, reset, clr, en,
						 input logic [WIDTH-1:0] d,
						output logic [WIDTH-1:0] q);
						
always_ff @(posedge clk, posedge reset, posedge clr)
	if (reset) q <= 0;
	else if (clr) q <= 0;
	else if (en) q <= q;
	else q <= d;
	
endmodule 