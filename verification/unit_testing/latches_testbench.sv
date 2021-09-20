module latchesTestBench #(parameter WIDTH = 32,
								  parameter outputFile = "outputs/latches_output.txt",
								  parameter inputFile = "inputs/latches_input.txt")
							    ();

reg   clk, reset, en;
logic [WIDTH-1:0] d, q, qbar;
logic [WIDTH-1:0] values[9:0];
integer f, i;

Dlatch #(WIDTH) Dlatch_ (en, d, q, qbar);

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
		en = values[i];
		d = values[i+5];
		@(posedge clk);
		$display("D-LATCH %d - %d = %d - %d", en, d, q, qbar);
		$fwrite(f,"%b\n", q);
		$fwrite(f,"%b\n", qbar);
	end
	$fclose(f);
	
end
  
endmodule