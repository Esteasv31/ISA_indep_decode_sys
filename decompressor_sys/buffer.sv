/* 
 * SIMPLE BUFFER
 */
module BUFFER #(parameter WIDTH = 32)
					(input logic [WIDTH-1:0] a,
					output logic [WIDTH-1:0] b);
				  
assign b = a;

endmodule 