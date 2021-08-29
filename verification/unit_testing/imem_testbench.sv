module imemTestBench #(parameter WIDTH = 32,
							  parameter SIZE = 64,
				           parameter FILE = "memfile.dat",
							  parameter outputFile = "mux_output.txt",
							  parameter inputFile = "mux_input.txt")
						    ();

reg   clk,reset;
logic [WIDTH-1:0] a, rd;
logic [WIDTH-1:0] values[4:0];
integer f, i;

imem #(WIDTH, SIZE, FILE) mem (a, rd);

always #5 clk=~clk;

//Clock and reset release
initial begin
	$readmemb(inputFile, values);
	clk=0; reset=1; //Clock low at time zero
	@(posedge clk);
	@(posedge clk);
	reset=0;
end

initial begin

	f = $fopen(outputFile,"w");
	@(negedge reset); //Wait for reset to be released
   @(posedge clk);   //Wait for fisrt clock out of reset
	for (i = 0; i<5; i=i+1) begin
		a = values[i];
		@(posedge clk);
		$display("A %d ; RD %b", a, rd);
		$fwrite(f,"%h\n",   rd);
	end
	$fclose(f);
	
end
  
endmodule