module FLOPR #(parameter WIDTH = 32, parameter INITVALUE = 0)
				  (input logic clk, reset, en,
				   input logic [WIDTH-1:0] d,
				  output logic [WIDTH-1:0] q);
				  
always_ff @(posedge clk, posedge reset)
	if (reset) q <= INITVALUE;
	else if (en) q <= q;
	else q <= d;
	
endmodule 
	
module FLOPRF #(parameter WIDTH = 32, parameter INITVALUE = 0)
				  (input logic clk, reset,
				   input logic [WIDTH-1:0] d,
				  output logic [WIDTH-1:0] q,
				  output logic full);
				  
always @(posedge clk, posedge reset)
	if (reset) q <= INITVALUE;
	else q <= d;
	if(q !== 32'bx || q !== 32'b0) begin
		assign full = 1;
	end 
	else begin
		assign full = 0;
	end 
	
endmodule 