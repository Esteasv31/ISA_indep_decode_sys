module bufferTestBench #(parameter WIDTH = 32,
								 parameter outputFile = "outputs/buffer_output.txt",
								 parameter inputFile = "inputs/buffer_input.txt")
							   ();

reg   clk,reset;
logic [WIDTH-1:0] a, b;
logic [WIDTH-1:0] values[4:0];
integer f, i;

BUFFER #(WIDTH) buffer (a, b);

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
		$display("BUFFER %d = %d", a, b);
		$fwrite(f,"%b\n",   b);
	end
	$fclose(f);
	
end
  
endmodule