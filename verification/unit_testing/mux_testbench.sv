module muxTestBench #(parameter WIDTH = 32,
							 parameter outputFile = "mux_output.txt",
							 parameter inputFile = "mux_input.txt")
						   ();

reg   clk,reset, cond;
logic [WIDTH-1:0] a, b, c;
logic [WIDTH-1:0] values[14:0];
integer f, i;

MUX2 #(WIDTH) mux (a, b, cond, c);

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
		b = values[i+5];
		cond = values[i+10];
		@(posedge clk);
		$display("A %d ; B %d ; COND %d ; C %d", a, b, cond, c);
		$fwrite(f,"%b\n",   c);
	end
	$fclose(f);
	
end
  
endmodule