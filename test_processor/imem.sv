module imem #(parameter WIDTH = 32,
				  parameter SIZE = 64)
				 (input logic [WIDTH-1:0] a,
				 output logic [WIDTH-1:0] rd);
				
logic [WIDTH-1:0] RAM[SIZE-1:0];

initial
	$readmemh("../verification/test_processor/memfile.dat", RAM);

assign rd = RAM[a[WIDTH-1:2]]; // word aligned

endmodule
