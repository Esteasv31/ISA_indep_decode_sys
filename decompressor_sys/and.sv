/* 
 * AND logic gate
 * WIDTH = length of the word of the system
 * INPUTS -> a & b - with size equal WIDTH
 * OUTPUT -> c - one bit size
 */
module ANDModule #(parameter WIDTH = 32)
				(input logic [WIDTH-1:0] a, b,
				output logic c);
				  
assign c = a == b;

endmodule 