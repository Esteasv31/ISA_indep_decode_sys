module floprTestBench #(parameter WIDTH = 32,
								parameter outputFile = "flopr_output.txt",
								parameter inputFile = "flopr_input.txt")
							  ();
					
logic clk, reset, en;
logic [WIDTH-1:0] d, q;
logic [WIDTH-1:0] values[9:0];
integer f, i;

FLOPR #(WIDTH) flopr (clk, reset, en, d, q);

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
	for (i = 0; i<5; i=i+1) begin
		d = values[i];
		en = values[i+5];
		@(posedge clk);
		@(posedge clk);
		$display("en = %b ; d = %d ; q = %d", en, d, q);
		$fwrite(f,"%b\n", q);
	end
	$fclose(f);
	
end
  
endmodule