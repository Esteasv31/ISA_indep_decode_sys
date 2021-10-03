/* 
 * Logical comparator
 * WIDTH = length of the word of the system
 * INPUTS -> a & b - with size equal WIDTH
 * OUTPUT -> c - one bit size
 *
 * 0 -> represents NOT equal PC's so the sys bring out a new instruction
 * 1 -> represents EQUAL PC's so no new instruction is given
 */

module COMPARATOR #(parameter WIDTH = 32)
						 (input logic [WIDTH-1:0] a, b,
						 output logic c);
				  
assign c = a == b;

endmodule 