/* logical comparator
 *
 * For the case of the decompressor sys
 *
 * 0 -> represents NOT equal PC's so the sys bring out a new instruction
 *
 * 1 -> represents EQUAL PC's so no new instruction is given
 *
 */

module COMPARATOR #(parameter WIDTH = 32)
						 (input logic [WIDTH-1:0] a, b,
						 output logic c);
				  
assign c = a == b;

endmodule 