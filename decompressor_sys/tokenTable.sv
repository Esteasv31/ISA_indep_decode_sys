module tokenTable #(parameter WIDTH = 32,
						  parameter SIZE = 64,
						  parameter FILE = "memfile.dat")
						 (input logic [WIDTH-1:0] a, b, data,
						  input logic clk, en, 
						 output logic [WIDTH-1:0] rd1, rd2);
				
logic [WIDTH-1:0] ROM[SIZE-1:0];

initial
	$readmemh(FILE, ROM);
	
always_ff @(posedge clk)
	if (en) ROM[a[WIDTH-1:2]] = data;

assign rd1 = ROM[a[WIDTH-1:2]]; // word aligned
assign rd2 = ROM[b[WIDTH-1:2]]; // word aligned

endmodule
