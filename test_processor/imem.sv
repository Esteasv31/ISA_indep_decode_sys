module imem #(parameter WIDTH = 32,
				  parameter SIZE = 64,
				  parameter FILE = "memfile.dat")
				 (input logic [WIDTH-1:0] a,
				 output logic [WIDTH-1:0] rd);
				
logic [WIDTH-1:0] ROM[SIZE-1:0];

initial
	$readmemh(FILE, ROM);

assign rd = ROM[a[WIDTH-1:2]]; // word aligned

endmodule
