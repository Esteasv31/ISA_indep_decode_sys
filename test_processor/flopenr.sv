/* 
 * custom FLIP-FLOP 
 * holds an enable (en) signal to change the register value
 * if en (0) it holds the prev value / if en (1) the value change on the positive edge of the clk
 */
module FLOPENR #(parameter WIDTH = 32)
					 (input logic clk, reset, en,
					  input logic [WIDTH-1:0] d,
					 output logic [WIDTH-1:0] q);
						
always_ff @(posedge clk, posedge reset)
	if (reset) q <= 0;
	else if (en) q <= d;
	
endmodule
