/* 
 * D flip-flop 
 * Used for the PC register
 * if en (1) it holds the prev value / if en (0) the value change on the positive edge of the clk
 * WIDTH = length of the word in the system
 * INITVALUE = init value of the register on t=0 or reset of the register
 */
module FLOPR #(parameter WIDTH = 32, parameter INITVALUE = 0)
				  (input logic clk, reset, en,
				   input logic [WIDTH-1:0] d,
				  output logic [WIDTH-1:0] q);
				  
always_ff @(posedge clk, posedge reset)
	if (reset) q <= INITVALUE;
	else if (en) q <= q;
	else q <= d;
	
endmodule 
