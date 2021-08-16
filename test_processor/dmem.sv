module dmem #(parameter WIDTH = 32,
				  parameter SIZE = 64)
				 (input logic clk, we,
				  input logic [WIDTH-1:0] a, wd,
				 output logic [WIDTH-1:0] rd1);
				
logic [WIDTH-1:0] RAM[SIZE-1:0];

assign rd1 = RAM[a[WIDTH-1:2]]; // word aligned

always_ff @(posedge clk)
	if (we) RAM[a[WIDTH-1:2]] <= wd;

endmodule
