/* 
 * Logic gate to compare if input a is higher or lower than the input b
 * OUTPUT -> c - one bit size
 */
module GratherLess #(parameter WIDTH = 32)
						  (input logic [WIDTH-1:0] a, b,
						  output logic c);
				  
assign c = (a < b) | (a > b);

endmodule 