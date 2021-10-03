/* 
 * Logical ADDER  
 * WIDTH = length of word in the system
 * 
 * 
 */
module ADD #(parameter WIDTH = 32)
				  (input logic [WIDTH-1:0] a, b,
				  output logic [WIDTH-1:0] c);
				  
assign c = a + b;

endmodule 